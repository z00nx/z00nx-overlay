# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit user
DESCRIPTION="Metapackage to install ArchiveTeam's Warrior"
HOMEPAGE="http://www.archiveteam.org/index.php?title=ArchiveTeam_Warrior"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-misc/wget-lua
        dev-python/seesaw
        app-admin/sudo
        dev-python/requests
        dev-python/pip"
RDEPEND="${DEPEND}"
S=${WORKDIR}

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN} --system
}

src_install() {
	newinitd "${FILESDIR}"/warrior.initd warrior
	newconfd "${FILESDIR}"/warrior.confd warrior
	insinto /etc/sudoers.d/
	insopts -m 0600 -o root -g root
	doins "${FILESDIR}/warrior-sudoers-r2"
}
