# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="olefile is a Python package to parse, read and write Microsoft OLE2 files"
HOMEPAGE="http://www.decalage.info/python/olefileio"
SRC_URI="https://bitbucket.org/decalage/olefileio_pl/downloads/${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"
