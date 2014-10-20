# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3
DESCRIPTION="dependency tool for go"
HOMEPAGE="https://github.com/tools/godep"
EGIT_REPO_URI="https://github.com/tools/godep.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/go"
RDEPEND="${DEPEND}"

GO_PN="github.com/tools/${PN}"
EGIT_CHECKOUT_DIR="${S}/src/${GO_PN}"

export GOPATH="${S}"

src_prepare(){
	go get ${GO_PN}
}

src_compile() {
	go build -v -x -work ${GO_PN} || die
}

src_install() {
	dobin ${S}/godep
	dodoc ${S}/src/github.com/tools/godep/Readme.md
}
