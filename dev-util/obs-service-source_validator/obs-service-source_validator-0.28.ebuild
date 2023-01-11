# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

# inherit git-r3

# EGIT_REPO_URI="https://github.com/openSUSE/obs-service-source_validator.git -> ${P}.git"
# EGIT_BRANCH="master"
# EVCS_UMASK="002"

DESCRIPTION="An OBS source service to find common pitfalls in package sources"
HOMEPAGE="https://github.com/openSUSE/obs-service-source_validator"
SRC_URI="https://github.com/openSUSE/obs-service-source_validator/archive/refs/tags/${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

BDEPEND="
	app-arch/zstd
"

RDEPEND="
	app-crypt/gnupg
	app-shells/bash
	dev-lang/perl
	dev-perl/TimeDate
	sys-devel/patch
"

# src_unpack() {
# 	git-r3_src_unpack
# }

src_compile() {
	true
}

src_install() {
	emake install DESTDIR=${ED}
}
