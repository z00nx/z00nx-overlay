# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user
DESCRIPTION="Smart PVR for newsgroup users"
HOMEPAGE="http://nzbdrone.com/"
SRC_URI="http://update.nzbdrone.com/repos/apt/debian/pool/main/n/${PN}/${PN}_${PV}_all.deb"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libmediainfo
	dev-lang/mono"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN} --system
}

src_unpack() {
	ar x "${DISTDIR}/${PN}_${PV}_all.deb"
	tar xvf "${WORKDIR}/data.tar.xz"
	rm -fv data.tar.xz control.tar.gz debian-binary
	mkdir -p "${WORKDIR}/usr/$(get_libdir)"
	mv "${WORKDIR}/opt/NzbDrone" "${WORKDIR}/usr/$(get_libdir)/${PN}"
	rmdir "${WORKDIR}/opt"
	mkdir -p "${S}"
}

src_install() {
	make_wrapper ${PN} "mono /usr/$(get_libdir)/${PN}/NzbDrone.exe"
	cp -r "${WORKDIR}/usr" "${D}/"
	newinitd "${FILESDIR}"/nzbdrone.initd nzbdrone
	newconfd "${FILESDIR}"/nzbdrone.confd nzbdrone
}

pkg_postinst() {
        elog "NzbDrone has been installed with data directories in /var/lib/${PN}"
        elog
        elog "New user/group ${PN}/${PN} has been created"
        elog
        elog "Start with ${ROOT}etc/init.d/${PN} start"
        elog "Visit http://<host ip>:8989 to configure NzbDrone"
}
