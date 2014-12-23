# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.7"
inherit git-2 python eutils
DESCRIPTION="Binary analysis framework"
HOMEPAGE="https://github.com/botherder/viper"
EGIT_REPO_URI="https://github.com/botherder/viper.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-python/python-magic
	dev-python/pefile
	dev-python/prettytable
	dev-python/pydeep
	dev-python/requests
	dev-python/sqlalchemy
	dev-python/pycrypto
	dev-python/olefile
	dev-python/beautifulsoup:4
	dev-python/bottle
	dev-python/pylzma
	dev-python/pyelftools
	dev-python/bitstring
	dev-python/dnspython
	doc? ( dev-python/sphinx )"
RDEPEND="${DEPEND}"

pkg_setup (){
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	insinto /usr/share/${PN}
	doins -r api.py data modules update.py viper viper.py web.py
	cd docs
	emake man
	dodoc build/man/viper.1
	make_wrapper ${PN} "python2 /usr/share/${PN}/viper.py"
	make_wrapper ${PN}-web "python2 /usr/share/${PN}/web.py"
}
pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
