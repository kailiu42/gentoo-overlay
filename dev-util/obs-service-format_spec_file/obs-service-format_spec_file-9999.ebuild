# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/openSUSE/obs-service-format_spec_file.git -> ${P}.git"
EGIT_BRANCH="master"
EVCS_UMASK="002"

DESCRIPTION="An OBS source service to reformats a spec file to SUSE standard"
HOMEPAGE="https://github.com/openSUSE/obs-service-format_spec_file"
#SRC_URI="https://github.com/openSUSE/obs-service-format_spec_file/archive/refs/tags/${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-shells/bash
	dev-lang/perl
	sys-apps/diffutils
	virtual/perl-Data-Dumper
"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	true
}

src_install() {
	emake install DESTDIR=${ED}
}
