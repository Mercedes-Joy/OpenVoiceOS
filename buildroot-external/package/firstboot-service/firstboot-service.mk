################################################################################
#
# firstboot-service
#
################################################################################

FIRSTBOOT_SERVICE_VERSION = 0.1.0
FIRSTBOOT_SERVICE_SITE = $(BR2_EXTERNAL_MYCROFTOS_PATH)/package/firstboot-service
FIRSTBOOT_SERVICE_SITE_METHOD = local
FIRSTBOOT_SERVICE_LICENSE = Apache License 2.0
FIRSTBOOT_SERVICE_LICENSE_FILES = LICENSE

define FIRSTBOOT_SERVICE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/resizeSD $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -m 0755 $(@D)/firstboot $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -D -m 644 $(@D)/firstboot.service \
		$(TARGET_DIR)/usr/lib/systemd/system/firstboot.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/sysinit.target.wants
	ln -fs ../../../../usr/lib/systemd/system/firstboot.service \
		$(TARGET_DIR)/etc/systemd/system/sysinit.target.wants/firstboot.service
	touch $(TARGET_DIR)/etc/firstboot
endef

$(eval $(generic-package))
