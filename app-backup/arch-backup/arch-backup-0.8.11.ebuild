# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit multilib

DESCRIPTION="trivial backup scripts (ssh/smb support)"
HOMEPAGE="https://github.com/p5n/archlinux-stuff"
SRC_URI="http://archlinux-stuff.googlecode.com/files/arch-backup-${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-text/txt2man"
DEPEND="${RDEPEND}"

S=${WORKDIR}/arch-backup-${PV}

src_install() {
	install -D -m 0644 ${S}/arch-backup.conf ${ED}/etc/arch-backup/arch-backup.conf
	install -D -m 0755 ${S}/arch-backup.sh ${ED}/usr/bin/arch-backup
	install -D -m 0755 ${S}/ssh-backup.sh ${ED}/usr/lib/arch-backup/ssh
	install -D -m 0755 ${S}/smb-backup.sh ${ED}/usr/lib/arch-backup/smb
	install -D -m 0755 ${S}/local-backup.sh ${ED}/usr/lib/arch-backup/local
	install -D -m 0644 ${S}/common.inc ${ED}/usr/lib/arch-backup/common.inc
	install -D -m 0644 ${S}/local-example.conf ${ED}/etc/arch-backup/_local-example
	install -D -m 0644 ${S}/ssh-example.conf ${ED}/etc/arch-backup/_ssh-example
	install -D -m 0644 ${S}/smb-example.conf ${ED}/etc/arch-backup/_smb-example
	install -D -m 0644 ${S}/arch-backup.8 ${ED}/usr/share/man/man8/arch-backup.8
}
