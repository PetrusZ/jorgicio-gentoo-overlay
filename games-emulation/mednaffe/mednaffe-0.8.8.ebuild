# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic gnome2-utils xdg-utils

DESCRIPTION="A front-end (GUI) for mednafen emulator"
HOMEPAGE="https://github.com/AmatCoder/mednaffe"
SRC_URI="https://github.com/AmatCoder/mednaffe/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=games-emulation/mednafen-1.21.1[debugger]
	gtk3? ( >=x11-libs/gtk+-3.4:3 )
	!gtk3? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig"

src_prepare() {
	default
	append-cflags -Wl,-export-dynamic
	sed -i -e 's:$(datadir):/usr/share:' share/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf $(use_enable gtk3)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
