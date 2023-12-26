EAPI=8

PYTHON_COMPAT=( python3_9 python3_10 python3_11 python3_12 )

inherit python-single-r1

DESCRIPTION="A user and group account administration library"
HOMEPAGE="https://pagure.io/libuser/"
RESTRICT="mirror"
SRC_URI="https://releases.pagure.org/${PN}/${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-audit doc -gtk-doc -ldap -nls -selinux"

RDEPEND="
	audit? ( sys-process/audit )
	gtk-doc? ( dev-util/gtk-doc )
	ldap? ( net-nds/openldap )
	selinux? ( sys-libs/libselinux )
	app-text/linuxdoc-tools
	dev-libs/cyrus-sasl
	dev-libs/glib
	dev-libs/popt
	sys-libs/pam
	${PYTHON_DEPS}
	"
DEPEND="${RDEPEND}"

src_configure () {
	./autogen.sh
	local myconf=(
		$(use_enable gtk-doc)
		$(use_enable nls)
		$(use_with audit)
		$(use_with ldap)
		$(use_with selinux)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	dodoc COPYING AUTHORS NEWS README TODO docs/*.txt
}
