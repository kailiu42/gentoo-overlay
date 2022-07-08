EAPI=7

inherit eutils

if [ ${PV} = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/makedumpfile/makedumpfile.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.gz"
fi

DESCRIPTION="Make vmcore smaller by filtering and compressing pages "
HOMEPAGE="https://github.com/makedumpfile/makedumpfile"
RESTRICT="mirror"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lzo +snappy +zstd"

RDEPEND="
	dev-libs/elfutils
	lzo? ( dev-libs/lzo )
	snappy? ( app-arch/snappy )
	zstd? ( app-arch/zstd )
	"
DEPEND="${RDEPEND}"

src_compile () {
	emake \
		LINKTYPE=dynamic \
		USELZO=$(usex lzo on off) \
		USESNAPPY=$(usex snappy on off) \
		USEZSTD=$(usex zstd on off)
}
