################################################################################
#
# thundercomm-rubik-pi3-firmware
#
################################################################################

THUNDERCOMM_RBPI3_FIRMWARE_VERSION = r1.0_00114.0
THUNDERCOMM_RBPI3_FIRMWARE_SITE = $(call github,rubikpi-ai,boot-assets,$(THUNDERCOMM_RBPI3_FIRMWARE_VERSION))
THUNDERCOMM_RBPI3_FIRMWARE_INSTALL_IMAGES = YES
THUNDERCOMM_RBPI3_FIRMWARE_LICENSE = Qualcomm Proprietary
THUNDERCOMM_RBPI3_FIRMWARE_LICENSE_FILES = LICENSE.txt

define THUNDERCOMM_RBPI3_FIRMWARE_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/rbpi3-firmware/
	find $(@D) -maxdepth 1 -name "*.elf" -exec install -m 0644 {} ${BINARIES_DIR}/rbpi3-firmware/ \;
	find $(@D) -maxdepth 1 -name "*.mbn" -exec install -m 0644 {} ${BINARIES_DIR}/rbpi3-firmware/ \;
	find $(@D) -maxdepth 1 -name "*.fv" -exec install -m 0644 {} ${BINARIES_DIR}/rbpi3-firmware/ \;
	find $(@D) -maxdepth 1 -name "*.img" -exec install -m 0644 {} ${BINARIES_DIR}/rbpi3-firmware/ \;
endef

$(eval $(generic-package))
