################################################################################
#
# OpenEMS
#
################################################################################

OPENEMS_VERSION = 2025.2.0
OPENEMS_URL = https://github.com/OpenEMS/openems
OPENEMS_FOLDER = openems-$(OPENEMS_VERSION)
OPENEMS_ARCHIVE = $(OPENEMS_VERSION).tar.gz
OPENEMS_EXTRA_DOWNLOADS = $(OPENEMS_URL)/archive/refs/tags/$(OPENEMS_ARCHIVE)

include $(sort $(wildcard package/openems/*/*.mk))
