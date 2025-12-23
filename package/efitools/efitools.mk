################################################################################
#
# efitools
#
################################################################################

EFITOOLS_VERSION = 1.9.2
EFITOOLS_SITE = https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/snapshot
EFITOOLS_LICENSE = GPL-2.0+ with OpenSSL exception, LGPL-2.1+
EFITOOLS_LICENSE_FILES = COPYING

EFITOOLS_DEPENDENCIES = gnu-efi openssl
EFITOOLS_CONFIGURE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	INCDIR_PREFIX="$(STAGING_DIR)" \
	ARCH="$(GNU_EFI_PLATFORM)"

define EFITOOLS_BUILD_CMDS
	$(EFITOOLS_CONFIGURE_OPTS) $(MAKE) -C $(@D) binaries
endef

define EFITOOLS_INSTALL_TARGET_CMDS
	$(EFITOOLS_CONFIGURE_OPTS) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install-binaries
endef

HOST_EFITOOLS_DEPENDENCIES = host-gnu-efi host-openssl
HOST_EFITOOLS_CONFIGURE_OPTS = \
	$(HOST_CONFIGURE_OPTS) \
	INCDIR_PREFIX="$(HOST_DIR)" \
	CRTPATH_PREFIX="$(HOST_DIR)" \
	EXTRA_LDFLAGS="$(HOST_LDFLAGS)"

define HOST_EFITOOLS_BUILD_CMDS
	$(HOST_EFITOOLS_CONFIGURE_OPTS) $(MAKE) -C $(@D) binaries
endef

define HOST_EFITOOLS_INSTALL_CMDS
	$(HOST_EFITOOLS_CONFIGURE_OPTS) $(MAKE) -C $(@D) DESTDIR=$(HOST_DIR) install-binaries
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
