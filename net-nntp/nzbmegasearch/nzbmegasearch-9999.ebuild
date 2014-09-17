# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.7"

inherit git-2 python user

DESCRIPTION="Aggregate automatically NZB search results. Easy. Quick. Clean."
HOMEPAGE="http://pillone.github.io/usntssearch/"
EGIT_REPO_URI="https://github.com/pillone/usntssearch.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/pyopenssl"
RDEPEND="${DEPEND}"

pkg_setup (){
        python_set_active_version 2
        python_pkg_setup
        enewgroup ${PN}
        enewuser ${PN} -1 -1 -1 ${PN} --system
}

src_install (){
	newinitd "${FILESDIR}"/nzbmegasearch.initd nzbmegasearch
	newconfd "${FILESDIR}"/nzbmegasearch.confd nzbmegasearch
	insinto "/etc/${PN}"
	insopts -m0660 -o "${PN}" -g "${PN}"
	doins "${FILESDIR}/${PN}.ini"
	insinto /usr/share/${PN}
	doins -r NZBmegasearch/*
	dosym "/etc/${PN}/${PN}.ini" "/usr/share/${PN}/custom_params.ini"
	make_wrapper ${PN} "python2 /usr/share/${PN}/mega2.py"
	rm -r ${D}/usr/share/${PN}/logs
	dodir "/var/log/${PN}"
	keepdir "/var/log/${PN}"
	fowners -R ${PN}:${PN} /var/log/${PN}
	dosym "/var/log/${PN}" "/usr/share/${PN}/logs"
}

pkg_postinst() {
        python_mod_optimize /usr/share/${PN}

        elog "New user/group ${PN}/${PN} has been created"
        elog "Config file is located in /etc/${PN}/${PN}.ini"
        elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
        elog "Start with ${ROOT}etc/init.d/${PN} start"
        elog "Visit http://<host ip>:5000 to configure NZBMegasearch"
}

pkg_postrm() {
        python_mod_cleanup /usr/share/${PN}
}

