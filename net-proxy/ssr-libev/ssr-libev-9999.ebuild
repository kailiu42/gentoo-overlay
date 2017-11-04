# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils systemd git-r3 user

DESCRIPTION="libev port of ShadowsocksR"
HOMEPAGE="https://github.com/shadowsocksr-backup/shadowsocksr-libev"

EGIT_REPO_URI="https://github.com/shadowsocksr-backup/shadowsocksr-libev.git"
EGIT_BRANCH="master"
EGIT_COMMIT="e2373d7199102f383b741da148b989c7c1e8832e"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND="net-libs/mbedtls
	>=dev-libs/libsodium-1.0.8
	dev-libs/libev
	net-libs/udns
	dev-libs/libpcre
	"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	doc? (
		app-text/asciidoc
		app-text/xmlto
	)
	"

pkg_setup() {
	enewgroup ssr
	enewuser ssr -1 -1 -1 ssr
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=" \
		$(use_enable debug assert) \
	"
	use doc || myconf+="--disable-documentation"
	myconf+=" --program-transform-name=s/ss-/ssr-/"
	econf ${myconf}
}

src_install() {
	default
	prune_libtool_files --all

	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	newins "${FILESDIR}/ssr.json" ssr.json

	dodoc -r acl

	systemd_newunit "${FILESDIR}/${PN}-local_at.service" "${PN}-local@.service"
	systemd_newunit "${FILESDIR}/${PN}-redir_at.service" "${PN}-redir@.service"

	# Don't need these and they conflict with ss
	rm -rf ${ED}/usr/lib64
	rm -rf ${ED}/usr/include
}
