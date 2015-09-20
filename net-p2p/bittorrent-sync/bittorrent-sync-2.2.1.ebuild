# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Device to device. Skip the cloud. Fast, private file sharing for teams and individuals."
HOMEPAGE="https://www.getsync.com/"
SRC_URI="x86?   ( https://download-cdn.getsync.com/stable/linux-i386/BitTorrent-Sync_i386.tar.gz -> ${P}-x86.tar.gz )
		 amd64? ( https://download-cdn.getsync.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz   -> ${P}-amd64.tar.gz )"

LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"
QA_PREBUILT="usr/bin/btsync"

src_install() {
	dobin btsync
	newinitd ${FILESDIR}/btsync.initd btsync
	newconfd ${FILESDIR}/btsync.confd btsync
	dodir /etc/btsync /var/lib/btsync
	insinto /etc/btsync
	newins ${FILESDIR}/config.json config
}

pkg_postinst() {
    elog "Bittorrent Sync has been installed and data is stored in /var/lib/btsync"
    elog
    elog "Start with ${ROOT}etc/init.d/btsync start"
    elog "Visit http://<host ip>:8888 to configure Bittorrent Sync"
	elog
	elog "If you are upgrading from, 1.4 you'll need to move the old data from"
	elog "/opt/btsync/.sync to /var/lib/btsync"
}
