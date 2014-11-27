# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Cuckoo Sandbox is an automated dynamic malware analysis system"
HOMEPAGE="http://www.cuckoosandbox.org/"
SRC_URI="https://github.com/cuckoobox/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+magic memory mongodb +pcap +pe32 test +web +yara"

DEPEND="dev-python/sqlalchemy
		dev-python/bson
		dev-python/jinja
		dev-python/chardet
		net-analyzer/tcpdump[-drop-root,suid]
		memory? ( app-forensics/volatility )
		pe32? ( dev-python/pefile )
		mongodb? ( dev-python/pymongo )
		pcap? ( dev-python/dpkt )
		magic? ( dev-python/python-magic )
		test? ( dev-python/nose )
		web? ( >=dev-python/bottle-0.10 >=dev-python/django-1.5 )
		yara? ( >=app-forensics/yara-1.7.2 >=dev-python/yara-python-1.7.2 )
		"
RDEPEND="${DEPEND}"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
#TODO: Write a python-maec ebuild and add as a use flag
