# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

BUILD="255606"

DESCRIPTION="The search engine for IT data"
HOMEPAGE="http://www.splunk.com"
SRC_URI="x86?   ( http://download.splunk.com/products/${PN}/releases/${PV}/${PN}/linux/${P}-${BUILD}-Linux-i686.tgz )
         amd64? ( http://download.splunk.com/products/${PN}/releases/${PV}/${PN}/linux/${P}-${BUILD}-Linux-x86_64.tgz )"

LICENSE="splunk-eula"
SLOT="6"
KEYWORDS="-* amd64"
IUSE=""
RESTRICT="strip"

DEPEND="!!net-analyzer/splunk:0"
RDEPEND="!net-analyzer/splunkforwarder"

S="${WORKDIR}"/${PN}

src_install() {
  dodir /opt
  mv "${S}" "${D}"/opt
  dodir /opt/splunk/var/log/splunk /opt/splunk/var/spool/splunk /opt/splunk/var/run/splunk
  dosym /opt/splunk/etc /etc/splunk
  dosym /opt/splunk/var/log/splunk /var/log/splunk
  dosym /opt/splunk/var/run/splunk /var/run/splunk
  dosym /opt/splunk/var/spool/splunk /var/spool/splunk
  dosym /opt/splunk/bin/splunk /usr/bin/splunk
  newinitd "${FILESDIR}"/splunk.initd splunk
  echo "LDPATH=/opt/splunk/lib" > "${T}/99splunk"
  doenvd "${T}/99splunk"
}
