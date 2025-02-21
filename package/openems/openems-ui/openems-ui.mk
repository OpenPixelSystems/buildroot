################################################################################
#
# OpenEMS UI
#
################################################################################

OPENEMS_UI_EXTRA_DOWNLOADS = $(OPENEMS_EXTRA_DOWNLOADS)
OPENEMS_UI_LICENSE = AGPL-3.0
OPENEMS_UI_LICENSE_FILES = LICENSE-AGPL-3.0
OPENEMS_UI_SITE = $(OPENEMS_URL)/releases/download/$(OPENEMS_VERSION)
OPENEMS_UI_SOURCE = openems-ui.tar.xz

define OPENEMS_UI_EXTRACT_CMDS
	$(call suitable-extractor,$(notdir $(OPENEMS_UI_EXTRA_DOWNLOADS))) \
		$(OPENEMS_UI_DL_DIR)/$(notdir $(OPENEMS_UI_EXTRA_DOWNLOADS)) | \
		$(TAR) -C $(@D) $(OPENEMS_FOLDER)/$(OPENEMS_UI_LICENSE_FILES)\
		--strip-components=1 $(TAR_OPTIONS) -
	$(call suitable-extractor,$(OPENEMS_UI_SOURCE)) \
		$(OPENEMS_UI_DL_DIR)/$(OPENEMS_UI_SOURCE) | \
		$(TAR) -C $(@D) --strip-components=1 $(TAR_OPTIONS) -
endef

define OPENEMS_UI_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/var/www
	cd $(@D) && find . -not -path '*/.*' -type d -exec \
		$(INSTALL) -m 755 -d {} $(TARGET_DIR)/var/www/{} \;
	cd $(@D) && find . -type f \( -path '*/.*' -o -name $(OPENEMS_UI_LICENSE_FILES) \) \
		-prune -o -exec $(INSTALL) -m 644 {} $(TARGET_DIR)/var/www/{} \;
endef

$(eval $(generic-package))
