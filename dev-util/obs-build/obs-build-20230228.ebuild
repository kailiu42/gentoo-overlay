# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="The openSUSE build tool"
HOMEPAGE="https://github.com/openSUSE/obs-build"
SRC_URI="https://github.com/openSUSE/obs-build/archive/refs/tags/${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-arch/libarchive
	app-arch/tar
	app-shells/bash
	dev-lang/perl
	sys-devel/binutils
	sys-process/psmisc
"
DEPEND="${RDEPEND}"

src_compile() {
	true
}

src_install() {
	make install DESTDIR=${ED}
}
