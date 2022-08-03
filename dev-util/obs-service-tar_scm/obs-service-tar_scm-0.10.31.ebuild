# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Source services for OBS which assist with packaging code from SCM into tarballs"
HOMEPAGE="https://github.com/openSUSE/obs-service-tar_scm"
SRC_URI="https://github.com/openSUSE/obs-service-tar_scm/archive/refs/tags/${PV}.tar.gz"
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
	dev-python/python-dateutil
"
DEPEND="${RDEPEND}"

src_compile() {
	true
}

src_install() {
	make install DESTDIR=${ED}
}
