EAPI=8

inherit multilib-minimal

DESCRIPTION="Preload library for disabling file's content synchronization"
HOMEPAGE="http://github.com/kjn/nosync"
RESTRICT="mirror"
SRC_URI="http://github.com/kjn/${PN}/archive/${PV}.tar.gz#/${P}.tar.gz"

LICENSE="ASL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}"/4.patch
)

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_compile() {
	emake CFLAGS="$CFLAGS"
}

multilib_src_install() {
	if multilib_is_native_abi; then
		emake install CFLAGS="$CFLAGS" libdir=${D}/usr/lib64
	else
		emake install CFLAGS="$CFLAGS" libdir=${D}/usr/lib
	fi
	dodoc AUTHORS README.md LICENSE NOTICE
}
