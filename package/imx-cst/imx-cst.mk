################################################################################
#
# imx-cst
#
################################################################################

# debian/3.4.0+dfsg
IMX_CST_VERSION = 3.4.0+dfsg
IMX_CST_SOURCE = imx-code-signing-tool_$(IMX_CST_VERSION).orig.tar.xz
IMX_CST_SITE = https://snapshot.debian.org/archive/debian/20250307T084701Z/pool/main/i/imx-code-signing-tool
IMX_CST_LICENSE = BSD-3-Clause
IMX_CST_LICENSE_FILES = LICENSE.bsd3

HOST_IMX_CST_DEPENDENCIES = host-byacc host-flex host-openssl

ifneq ($(filter %64,$(HOSTARCH)),)
HOST_IMX_CST_OSTYPE = linux64
else
HOST_IMX_CST_OSTYPE = linux32
endif

# We don't use HOST_CONFIGURE_OPTS when building cst, because we need
# to preserve the CFLAGS/LDFLAGS used by their Makefile.
define HOST_IMX_CST_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) \
		OSTYPE=$(HOST_IMX_CST_OSTYPE) \
		OPENSSL_PATH=$(HOST_DIR)/include/openssl \
		ENCRYPTION=yes \
		AR="$(HOSTAR)" \
		CC="$(HOSTCC)" \
		LD="$(HOSTCC)" \
		OBJCOPY="$(HOSTOBJCOPY)" \
		RANLIB="$(HOSTRANLIB)" \
		EXTRACFLAGS="$(HOST_CFLAGS) $(HOST_CPPFLAGS) \
			-Wno-error=unused-result" \
		EXTRALDFLAGS="$(HOST_LDFLAGS)" \
		-C $(@D)
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		COPTS="$(HOST_CFLAGS) $(HOST_CPPFLAGS) $(HOST_LDFLAGS)" \
		-C $(@D)/add-ons/hab_csf_parser
endef

define HOST_IMX_CST_INSTALL_CMDS
	$(INSTALL) -D -m 755 $(@D)/code/obj.$(HOST_IMX_CST_OSTYPE)/cst $(HOST_DIR)/bin/cst
	$(INSTALL) -D -m 755 $(@D)/code/obj.$(HOST_IMX_CST_OSTYPE)/srktool $(HOST_DIR)/bin/srktool
	$(INSTALL) -D -m 755 $(@D)/add-ons/hab_csf_parser/csf_parser $(HOST_DIR)/bin/csf_parser
endef

$(eval $(host-generic-package))
