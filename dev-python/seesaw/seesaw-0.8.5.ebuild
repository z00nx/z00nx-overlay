# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="ArchiveTeam seesaw kit"
HOMEPAGE="https://github.com/ArchiveTeam/seesaw-kit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/sockjs-tornado
	>=www-servers/tornado-2.3
	dev-python/backports-ssl-match-hostname"
RDEPEND="${DEPEND}"
