HOST_QCA_SECTOOLS_VERSION = 1.50.0
HOST_QCA_SECTOOLS_SITE = https://softwarecenter.qualcomm.com/api/download/software/tools/Qualcomm_Security_Tools/All/$(HOST_QCA_SECTOOLS_VERSION)
HOST_QCA_SECTOOLS_SOURCE = $(subst .0,,$(HOST_QCA_SECTOOLS_VERSION)).zip
HOST_QCA_SECTOOLS_LICENSE = Qualcomm Proprietary
HOST_QCA_SECTOOLS_LICENSE_FILES = License.pdf

define HOST_QCA_SECTOOLS_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(HOST_QCA_SECTOOLS_DL_DIR)/$(HOST_QCA_SECTOOLS_SOURCE)
	mv $(@D)/$(subst .0,,$(HOST_QCA_SECTOOLS_VERSION))/* $(@D)
	rmdir $(@D)/$(subst .0,,$(HOST_QCA_SECTOOLS_VERSION))/
endef


HOST_QCA_SECTOOLS_BIN_PATH = "Linux"
ifeq ($(HOSTARCH),aarch64)
	HOST_QCA_SECTOOLS_BIN_PATH = "Linux-aarch64"
endif

define HOST_QCA_SECTOOLS_PATCH_RPATH
	$(HOST_DIR)/bin/patchelf --set-rpath $(HOST_DIR)/lib/ $(@D)/$(HOST_QCA_SECTOOLS_BIN_PATH)/sectools
endef
HOST_QCA_SECTOOLS_PRE_INSTALL_HOOKS += HOST_QCA_SECTOOLS_PATCH_RPATH

define HOST_QCA_SECTOOLS_INSTALL_CMDS
	$(INSTALL) $(@D)/$(HOST_QCA_SECTOOLS_BIN_PATH)/sectools $(HOST_DIR)/bin/
endef

$(eval $(host-generic-package))
