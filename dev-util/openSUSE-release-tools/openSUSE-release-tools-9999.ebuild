# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 tmpfiles

EGIT_REPO_URI="https://github.com/openSUSE/${PN}.git"

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE="xml"

DESCRIPTION="Tools to aid in staging and release work for openSUSE/SUSE "
HOMEPAGE="https://github.com/openSUSE/openSUSE-release-tools"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

RDEPEND=""
BDEPEND=""

src_install() {
	emake install \
		DESTDIR=${D} \
		oscplugindir="/usr/lib/osc-plugins" \
		VERSION="%{PV}"
}

pkg_postinst() {
	tmpfiles_process opensuse-abi-checker.conf
}
