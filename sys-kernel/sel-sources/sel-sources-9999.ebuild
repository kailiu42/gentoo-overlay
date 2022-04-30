# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="ssh://mirror-worker@git.suseeuler.net/suseEuler/kernel/kernel-source -> ${P}.git"
EGIT_BRANCH="SEL-2.0"
#EGIT_COMMIT="refs/changes/97/1297/1"
#EGIT_COMMIT="0e33be019783c76e97b7b6fcc00c734ebfc7faf6"
EGIT_CLONE_TYPE="mirror"
EVCS_UMASK="002"

DESCRIPTION="The SUSE Euler Linux kernel"
HOMEPAGE="https://gerrit.suseeuler.net/admin/repos/suseEuler/kernel/kernel-source,general"

SRC_URI="https://mirrors.aliyun.com/linux-kernel/v5.x/linux-5.10.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	cp ${DISTDIR}/linux-5.10.tar.xz .
	./scripts/sequence-patch.sh --fast

	cd tmp/current
	make ARCH=x86_64 distclean
	rm -f patches refresh_patch.sh run_oldconfig.sh series
	chmod -R u+w .

	local c=$(git rev-parse --short=7 HEAD)
	sed -i -e "s/^EXTRAVERSION =$/EXTRAVERSION = -sel.g$c/" Makefile
}

src_compile() {
	:;
}

src_install() {
	dodir /usr/src/
	cp -RL "${S}/tmp/current" "${D}/usr/src/linux-5.10-SEL-2.0" || die "Install failed!"
}
