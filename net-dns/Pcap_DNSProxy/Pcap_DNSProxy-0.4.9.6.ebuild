# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit systemd

DESCRIPTION="A local DNS server based on WinPcap and LibPcap that can filter out polluted DNS response"
HOMEPAGE="https://github.com/chengr28/Pcap_DNSProxy/releases"

SRC_URI="https://github.com/chengr28/Pcap_DNSProxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
	dev-libs/libsodium
	dev-libs/openssl
	net-libs/libpcap
"

DEPEND="${RDEPEND}
	dev-util/cmake
	>=sys-devel/gcc-4.9
"

src_compile() {
	cd Source/Auxiliary/Scripts
	chmod 755 CMake_Build.sh
	./CMake_Build.sh
}

src_install() {
	dobin Source/Release/Pcap_DNSProxy

	insinto /etc/Pcap_DNSProxy
	doins Source/Release/Config.conf
	doins Source/Release/Hosts.conf
	doins Source/Release/IPFilter.conf
	doins Source/Release/Routing.txt
	doins Source/Release/WhiteList.txt

	sed -e "s|^ExecStart=$|ExecStart=/usr/bin/Pcap_DNSProxy|g" \
		-e "s|^WorkingDirectory=$|WorkingDirectory=/etc/Pcap_DNSProxy|g" \
		-i Source/Release/Pcap_DNSProxy.service

	systemd_dounit Source/Release/Pcap_DNSProxy.service
}
