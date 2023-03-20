# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="xml"
DISTUTILS_SINGLE_IMPL=1

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Command line tool for Open Build Service"
HOMEPAGE="
	https://en.opensuse.org/openSUSE:OSC
	https://github.com/openSUSE/osc
"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/openSUSE/${PN}.git"
else
	SRC_URI="https://github.com/openSUSE/${PN}/archive/${PV/_beta/b}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
# Test require config file: osc.oscerr.NoConfigfile
RESTRICT="test"

RDEPEND="
	app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/cryptography[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/urllib3[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/progressbar2[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/distro[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/keyring[${PYTHON_USEDEP}]
	')
	${PYTHON_SINGLE_DEPS}
"
BDEPEND="
	$(python_gen_cond_dep '
		dev-python/cryptography[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/urllib3[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/setuptools-scm[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/pyxdg[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/argparse-manpage[${PYTHON_USEDEP}]
	')
	test? (
		${RDEPEND}
		$(python_gen_cond_dep '
			dev-python/path-py[${PYTHON_USEDEP}]
	')
)"

S="${WORKDIR}/${P/_beta/b}"

distutils_enable_tests pytest

src_compile() {
	distutils-r1_src_compile

	# Write rpm macros
	echo "%osc_plugin_dir /usr/lib/osc-plugins" > macros.osc

	# Build man page
	PYTHONPATH=. argparse-manpage \
		--output=osc.1 \
		--format=single-commands-section \
		--module=osc.commandline \
		--function=get_parser \
		--project-name=osc \
		--prog=osc \
		--description="OpenSUSE Commander" \
		--author="Contributors to the osc project. See the project's GIT history for the complete list." \
		--url="https://github.com/openSUSE/osc/"
}

src_install() {
	distutils-r1_src_install

	# create plugin dirs
	keepdir /usr/lib/osc-plugins
	keepdir /var/lib/osc-plugins

	# Completion for bash
	newbashcomp contrib/complete.sh "${PN}"
	insinto /usr/share/osc
	newins contrib/osc.complete complete

	# Completion for csh
	insinto /etc/profile.d
	newins contrib/complete.csh osc.csh

	# Completion for zsh
	insinto /usr/share/zsh/site-functions
	newins "${FILESDIR}/osc.zsh_completion" _osc

	# Completion for fish
	insinto /usr/share/fish/vendor_completions.d
	doins contrib/osc.fish

	# Install rpm macros
	insinto /usr/lib/rpm/macros.d
	doins macros.osc

	# Install man page
	doman osc.1
}
