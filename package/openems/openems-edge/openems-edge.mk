################################################################################
#
# OpenEMS Edge
#
################################################################################

OPENEMS_EDGE_EXTRA_DOWNLOADS = $(OPENEMS_EXTRA_DOWNLOADS)
OPENEMS_EDGE_LICENSE = EPL-2.0
OPENEMS_EDGE_LICENSE_FILES = LICENSE-EPL-2.0
OPENEMS_EDGE_SITE = $(OPENEMS_URL)/releases/download/$(OPENEMS_VERSION)
OPENEMS_EDGE_SOURCE = openems-edge.jar

define OPENEMS_EDGE_EXTRACT_CMDS
	$(call suitable-extractor,$(notdir $(OPENEMS_EDGE_EXTRA_DOWNLOADS))) \
		$(OPENEMS_EDGE_DL_DIR)/$(notdir $(OPENEMS_EDGE_EXTRA_DOWNLOADS)) | \
		$(TAR) -C $(@D) $(OPENEMS_FOLDER)/$(OPENEMS_EDGE_LICENSE_FILES) \
		--strip-components=1 $(TAR_OPTIONS) -
endef

define OPENEMS_EDGE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(OPENEMS_EDGE_DL_DIR)/$(OPENEMS_EDGE_SOURCE) \
		$(TARGET_DIR)/usr/bin/$(OPENEMS_EDGE_SOURCE)
endef

$(eval $(generic-package))
