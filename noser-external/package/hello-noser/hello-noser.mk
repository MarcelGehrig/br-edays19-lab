################################################################################
#
# hello Noser :-)
#
################################################################################

HELLO_NOSER_VERSION = 1.0
HELLO_NOSER_SITE = $(BR2_EXTERNAL)/package/hello-noser/src
HELLO_NOSER_SITE_METHOD = local

define HELLO_NOSER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/hello-noser $(TARGET_DIR)/usr/bin
endef

$(eval $(cmake-package))

