################################################################################
#
# ptool
#
################################################################################

PTOOL_VERSION = 8e85e196d2478e67b32558dc833be3beceeea512
PTOOL_SITE = $(call github,qualcomm-linux,qcom-ptool,$(PTOOL_VERSION))
PTOOL_LICENSE = BSD-3-Clause
PTOOL_LICENSE_FILES = LICENSE
PTOOL_SETUP_TYPE = setuptools

ifeq ($(BR2_PACKAGE_HOST_PTOOL_PLATFORM_RUBIKPI3),y)
	PLATFORM = qcs6490-thundercomm-rubikpi3
	STORAGE_TYPE = ufs
endif

define PTOOL_INSTALL_PLATFORM_PARTITIONS
	mkdir -p $(BINARIES_DIR)/partitions
	cp $(@D)/platforms/$(PLATFORM)/$(STORAGE_TYPE)/partitions.conf $(BINARIES_DIR)/partitions/
	cp $(@D)/platforms/$(PLATFORM)/$(STORAGE_TYPE)/contents.xml.in $(BINARIES_DIR)/partitions/
endef
HOST_PTOOL_POST_INSTALL_HOOKS += PTOOL_INSTALL_PLATFORM_PARTITIONS

$(eval $(host-python-package))
