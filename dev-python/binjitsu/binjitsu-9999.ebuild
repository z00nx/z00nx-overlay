# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="binjitsu is a CTF framework and exploit development library. Written in Python, it is designed for rapid prototyping and development, and intended to make exploit writing as simple as possible."
HOMEPAGE="https://github.com/binjitsu/binjitsu/"
EGIT_REPO_URI="https://github.com/binjitsu/binjitsu.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=">=dev-python/paramiko-1.15.2
	>=dev-python/mako-1.0.0
	>=dev-python/pyelftools-0.2.3
	dev-python/capstone-python
	>=dev-python/pyserial-2.7
	>=dev-python/requests-2.0
	>=dev-python/pip-6.0.8
	>=dev-python/pygments-2.0
	dev-python/PySocks
	dev-python/python-dateutil
	test? (
		dev-python/tox[${PYTHON_USEDEP}]
	)"
#ROPGadget
RDEPEND="${DEPEND}"
