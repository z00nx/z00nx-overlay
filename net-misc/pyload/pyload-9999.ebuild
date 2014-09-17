# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_TARGETS="python2_7"
inherit eutils git-2 python user
DESCRIPTION="A free and open source personal cloud storage as well as download manager for all kind of operating systems and devices, designed to be extremely lightweight and runnable on personal pc or headless server."
HOMEPAGE="http://pyload.org/"
EGIT_BRANCH="stable"
EGIT_REPO_URI="https://github.com/pyload/pyload.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="captcha clicknload container qt4 rar ssl"

DEPEND="
	dev-python/beautifulsoup
	dev-python/beaker
	dev-python/feedparser
	dev-python/simplejson
	dev-python/pycurl
	dev-python/jinja
	>=dev-python/beautifulsoup-3.2
	<dev-python/beautifulsoup-3.3
	captcha? ( app-text/tesseract
		dev-python/imaging
	)
	clicknload? (
	container? ( dev-python/pycrypto )
	|| (
		dev-lang/spidermonkey:0
		dev-java/rhino
	)
	)
	qt4? ( dev-python/PyQt4	)
	rar? ( app-arch/unrar )
	ssl? (
		dev-python/pyopenssl
		dev-python/pycrypto
	)"
	#TODO: webinterface? ( dev-python/bottle )"
	#NOTE: Jinja v2.5/v2.6 required and v2.7 is avaliable in portage
	#NOTE: Spidermonkey slot 0 needed
	#NOTE: You can't use virtual/python-imaging and must use dev-python/imaging
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN} --system
}

src_prepare() {
	epatch "${FILESDIR}/pyload-rc4-md5-default.patch"
	#NOTE: Needed for Mega.co.nz - http://forum.pyload.org/viewtopic.php?f=12&t=3311
}

src_install() {
	newinitd ${FILESDIR}/pyload.initd pyload
	newconfd ${FILESDIR}/pyload.confd pyload
	dodir "/usr/share/${PN}"
	rm -r "${WORKDIR}/${P}/.git"
	mv "${WORKDIR}/${P}" "${WORKDIR}/${PN}"
	insinto "/usr/share/"
	doins -r "${WORKDIR}/${PN}"
	dodir "/var/lib/${PN}"
	insinto "/var/lib/${PN}"
	insopts -m0660 -o "${PN}" -g "${PN}"
	cp "${D}/usr/share/${PN}/module/config/default.conf" "${D}/var/lib/${PN}/pyload.conf"
	doins "${FILESDIR}/files.db"
	fowners -R ${PN}:${PN} /var/lib/${PN}
	make_wrapper pyload "python2 /usr/share/${PN}/pyLoadCore.py"
	make_wrapper pyload-cli "python2 /usr/share/${PN}/pyLoadCli.py"
	make_wrapper pyload-gui "python2 /usr/share/${PN}/pyLoadGui.py"
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
	elog "pyLoad has been installed with data directories in /var/lib/${PN}"
	elog
	elog "New user/group ${PN}/${PN} has been created"
	elog
	elog "Config file is located in /etc/${PN}/${PN}.ini"
	elog
	elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${PN} start"
	elog "Visit http://<host ip>:8001 to configure pyLoad"
	elog "Default web username/password : pyload/pyload"
	elog
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
