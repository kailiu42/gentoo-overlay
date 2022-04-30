# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

PYTHON_COMPAT=( python3_{6..11} )

inherit git-r3

EGIT_REPO_URI="ssh://mirror-worker@git.suseeuler.net/infra/obs-service-merge_changelog -> ${P}.git"
EGIT_BRANCH="master"
EGIT_CLONE_TYPE="mirror"
EVCS_UMASK="002"

DESCRIPTION="An OBS source service to merge changelogs from spec and changes file"
HOMEPAGE="https://gerrit.suseeuler.net/admin/repos/infra/obs-service-merge_changelog"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
"
DEPEND="${RDEPEND}"

src_compile() {
	true
}

src_install() {
	install -m 755 -o root -g root -D -t ${ED}/usr/lib/obs/service merge_changelog
	install -m 644 -o root -g root -D -t ${ED}/usr/lib/obs/service merge_changelog.service
}
