# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit distutils-r1

DESCRIPTION="Python bindings for ssdeep"
HOMEPAGE="https://github.com/kbandla/pydeep"
if [[ "${PV}" == "9999" ]]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/kbandla/pydeep.git"
else
	SRC_URI="https://github.com/kbandla/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-crypt/ssdeep"
RDEPEND="${DEPEND}"
