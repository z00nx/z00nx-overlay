# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="tzinfo object for the local timezone"
HOMEPAGE="https://github.com/regebro/tzlocal"
SRC_URI="https://github.com/regebro/${PN}/archive/${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
