################################################################################
#
# docserver
#
################################################################################

DOCSERVER_VERSION = v0.0.2
DOCSERVER_SITE = https://github.com/usedbytes/docserver
DOCSERVER_SITE_METHOD = git
DOCSERVER_INSTALL_STAGING = NO
DOCSERVER_INSTALL_TARGET = YES

DOCSERVER_DEPENDENCIES = host-go

DOCSERVER_MAKE_ENV = \
	$(HOST_GO_TARGET_ENV) \
	GOBIN="$(@D)/bin" \
	GOPATH="$(@D)/gopath" \
	CGO_ENABLED=0

DOCSERVER_FLAGS=-a -installsuffix cgo -ldflags '-s'
GOCMD=$(HOST_DIR)/usr/bin/go

define DOCSERVER_CONFIGURE_CMDS
	# Put sources at prescribed GOPATH location.
	mkdir -p $(@D)/gopath/src/github.com/usedbytes
	ln -fs $(@D) $(@D)/gopath/src/github.com/usedbytes/docserver

	# Pull dependencies
	cd $(@D)/gopath/src/github.com/usedbytes/docserver && \
		$(DOCSERVER_MAKE_ENV) && $(GOCMD) get .
endef

define DOCSERVER_BUILD_CMDS
	cd $(@D) && $(DOCSERVER_MAKE_ENV) $(GOCMD) build -v \
		-o $(@D)/bin/docserver $(DOCSERVER_FLAGS) .
endef

define DOCSERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/docserver $(TARGET_DIR)/usr/local/bin/docserver
endef

$(eval $(generic-package))
