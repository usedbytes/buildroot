################################################################################
#
# gadget-doc
#
################################################################################

GADGET_DOC_VERSION = master
GADGET_DOC_SITE = https://github.com/usedbytes/gadget-doc
GADGET_DOC_SITE_METHOD = git
GADGET_DOC_INSTALL_STAGING = NO
GADGET_DOC_INSTALL_TARGET = YES

define GADGET_DOC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/share/doc/gadget-doc
	cp -r $(@D)/* $(TARGET_DIR)/usr/local/share/doc/gadget-doc/
endef

$(eval $(generic-package))
