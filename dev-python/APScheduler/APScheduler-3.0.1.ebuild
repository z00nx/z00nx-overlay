# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="In-process task scheduler with Cron-like capabilities"
HOMEPAGE="https://pypi.python.org/pypi/APScheduler/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		virtual/python-futures[${PYTHON_USEDEP}]
		test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

RDEPEND="${DEPEND}"

python_test() {
	py.test || die "Testing failed with ${EPYTHON}"
}
