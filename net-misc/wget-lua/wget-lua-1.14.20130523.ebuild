# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit flag-o-matic toolchain-funcs autotools versionator
MY_P1="wget"
MY_P2="lua"
MY_V="$(get_version_component_range 1-2)"
MY_DATE="$(get_version_component_range 3)"
MY_COMMIT="9a5c"
DESCRIPTION="Wget with Lua scripting"
HOMEPAGE="https://github.com/alard/wget-lua"
SRC_URI="http://warriorhq.archiveteam.org/downloads/wget-lua/${MY_P1}-${MY_V}.${MY_P2}.${MY_DATE}-${MY_COMMIT}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gnutls idn ipv6 nls ntlm pcre +ssl static uuid zlib"

LIB_DEPEND="idn? ( net-dns/libidn[static-libs(+)] )
	pcre? ( dev-libs/libpcre[static-libs(+)] )
	ssl? (
		gnutls? ( net-libs/gnutls[static-libs(+)] )
		!gnutls? ( dev-libs/openssl:0[static-libs(+)] )
	)
	uuid? ( sys-apps/util-linux[static-libs(+)] )
	zlib? ( sys-libs/zlib[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	static? ( ${LIB_DEPEND} )
	nls? ( sys-devel/gettext )
	dev-lang/lua"

REQUIRED_USE="ntlm? ( !gnutls ssl ) gnutls? ( ssl )"

DOCS=( AUTHORS MAILING-LIST NEWS README doc/sample.wgetrc )

S="${WORKDIR}/${MY_P1}-${MY_V}.${MY_P2}.${MY_DATE}-${MY_COMMIT}"

src_prepare() {
	epatch "${FILESDIR}"/${MY_P1}-1.13.4-openssl-pkg-config.patch \
		"${FILESDIR}"/${MY_P1}-${MY_V}-texi2pod.patch
	eautoreconf
}

src_configure() {
	# openssl-0.9.8 now builds with -pthread on the BSD's
	use elibc_FreeBSD && use ssl && append-ldflags -pthread
	# fix compilation on Solaris, we need filio.h for FIONBIO as used in
	# the included gnutls -- force ioctl.h to include this header
	[[ ${CHOST} == *-solaris* ]] && append-flags -DBSD_COMP=1

	# some libraries tests lack configure options :( #432468
	eval export ac_cv_{header_pcre_h,lib_pcre_pcre_compile}=$(usex pcre)
	eval export ac_cv_{header_uuid_uuid_h,lib_uuid_uuid_generate}=$(usex uuid)

	if use static ; then
		append-ldflags -static
		tc-export PKG_CONFIG
		PKG_CONFIG+=" --static"
	fi
	econf \
		--disable-rpath \
		$(use_with ssl ssl $(usex gnutls gnutls openssl)) \
		$(use_enable ssl opie) \
		$(use_enable ssl digest) \
		$(use_enable idn iri) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable ntlm) \
		$(use_enable debug) \
		$(use_with zlib)
}

src_install() {
	newbin src/wget wget-lua
}
