################################################################################
#
# sbsigntools
#
################################################################################

SBSIGNTOOLS_VERSION = v0.9.5
SBSIGNTOOLS_SITE = git://git.kernel.org/pub/scm/linux/kernel/git/jejb/sbsigntools.git
SBSIGNTOOLS_LICENSE = GPL-3.0+
SBSIGNTOOLS_LICENSE_FILES = COPYING \
	lib/ccan.git/licenses/BSD-3CLAUSE \
	lib/ccan.git/licenses/BSD-MIT \
	lib/ccan.git/licenses/GPL-2 \
	lib/ccan.git/licenses/GPL-3 \
	lib/ccan.git/licenses/LGPL-2.1 \
	lib/ccan.git/licenses/LGPL-3
SBSIGNTOOLS_AUTORECONF = YES
SBSIGNTOOLS_GIT_SUBMODULES = YES

SBSIGNTOOLS_DEPENDENCIES = host-pkgconf binutils gnu-efi openssl util-linux
HOST_SBSIGNTOOLS_DEPENDENCIES = host-pkgconf host-binutils host-gnu-efi host-openssl host-util-linux

SBSIGNTOOLS_CONF_ENV = \
	CRTPATH="$(STAGING_DIR)/lib/crt0-efi-$(GNU_EFI_PLATFORM).o"
HOST_SBSIGNTOOLS_CONF_ENV = \
	CRTPATH="$(HOST_DIR)/lib/crt0-efi-$(shell uname -m).o" \
	CFLAGS="$(HOST_CFLAGS) \
		-I$(HOST_BINUTILS_DIR)/include \
		-I$(HOST_BINUTILS_DIR)/bfd" \
	ac_cv_header_bfd_h=yes

define SBSIGNTOOLS_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef

SBSIGNTOOLS_PRE_CONFIGURE_HOOKS += SBSIGNTOOLS_RUN_AUTOGEN
HOST_SBSIGNTOOLS_PRE_CONFIGURE_HOOKS += SBSIGNTOOLS_RUN_AUTOGEN

define SBSIGNTOOLS_FIX_EFI_CPPFLAGS
	$(SED) 's|^EFI_ARCH=.*|EFI_ARCH=$(GNU_EFI_PLATFORM)|' $(@D)/configure.ac
	$(SED) 's|/usr/include/efi|$(STAGING_DIR)/usr/include/efi|g' $(@D)/configure.ac
endef

SBSIGNTOOLS_PRE_CONFIGURE_HOOKS += SBSIGNTOOLS_FIX_EFI_CPPFLAGS

define HOST_SBSIGNTOOLS_FIX_EFI_CPPFLAGS
	$(SED) 's|/usr/include/efi|$(HOST_DIR)/include/efi|g' $(@D)/configure.ac
endef

HOST_SBSIGNTOOLS_PRE_CONFIGURE_HOOKS += HOST_SBSIGNTOOLS_FIX_EFI_CPPFLAGS

$(eval $(autotools-package))
$(eval $(host-autotools-package))
