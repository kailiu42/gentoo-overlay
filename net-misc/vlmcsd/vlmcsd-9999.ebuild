# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd

DESCRIPTION="KMS Emulator in C"
HOMEPAGE="https://github.com/Wind4/vlmcsd"
# SRC_URI="https://github.com/Wind4/vlmcsd/archive/svn${PV}.tar.gz -> ${P}.tar.gz"

EGIT_REPO_URI="https://github.com/Wind4/vlmcsd"
EGIT_BRANCH="master"
EVCS_UMASK="002"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

#S="${WORKDIR}/${PN}-svn${PV}"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	emake
	emake man
}

src_install() {
	dobin ./bin/vlmcsd
	dobin ./bin/vlmcs

	dodir /etc/vlmcsd
	insinto /etc/vlmcsd
	doins ./etc/vlmcsd.ini
	doins ./etc/vlmcsd.kmd
	systemd_dounit "${FILESDIR}/vlmcsd.service"

	doman ./man/vlmcs.1
	doman ./man/vlmcsd-floppy.7
	doman ./man/vlmcsd.7
	doman ./man/vlmcsd.8
	doman ./man/vlmcsd.ini.5
	doman ./man/vlmcsdmulti.1
}
