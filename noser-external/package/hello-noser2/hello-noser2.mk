# ===================================================
# noser-external/package/hello-noser2/hello-noser2.mk
# ===================================================
HELLO_NOSER2_VERSION = 1.0
HELLO_NOSER2_SITE = $(BR2_EXTERNAL)/package/hello-noser2/src
HELLO_NOSER2_SITE_METHOD = local

define HELLO_NOSER2_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define HELLO_NOSER2_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/hello-noser2 $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))

