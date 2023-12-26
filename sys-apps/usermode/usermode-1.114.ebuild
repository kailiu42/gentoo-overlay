EAPI=8

DESCRIPTION="Tools for certain user account management tasks "
HOMEPAGE="https://pagure.io/usermode/"
RESTRICT="mirror"
SRC_URI="https://releases.pagure.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-gtk2 -nls -selinux"

RDEPEND="
	dev-libs/glib
	dev-libs/libuser
	dev-perl/XML-Parser
	sys-apps/util-linux
	sys-libs/pam
	nls? (
		dev-util/intltool
		sys-devel/gettext
	)
	selinux? ( sys-libs/libselinux )
	gtk2? (
		dev-util/desktop-file-utils
		x11-libs/gtk+:2
		x11-libs/startup-notification
		x11-libs/libSM
	)
	"
DEPEND="${RDEPEND}"

src_configure () {
	local myconf=(
		"--without-fexecve"
		$(use_enable nls)
		$(use_with selinux)
		$(use_with gtk2 gtk)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc/security/console.apps
	doins ${FILESDIR}/config-util

	fperms 4711 /usr/sbin/userhelper

	dodoc COPYING ChangeLog NEWS README

	if use gtk2; then
		dosym -r /usr/bin/usermount /usr/bin/userformat
		dosym -r /usr/share/man/man1/usermount.1 /usr/share/man/man1/userformat.1
		for i in redhat-userinfo.desktop redhat-userpasswd.desktop \
			redhat-usermount.desktop; do
			echo 'NotShowIn=GNOME;KDE;' >>$RPM_BUILD_ROOT%{_datadir}/applications/$i
			desktop-file-install --vendor redhat --delete-original \
				--dir $RPM_BUILD_ROOT%{_datadir}/applications \
				$RPM_BUILD_ROOT%{_datadir}/applications/$i
		done
	fi
}
