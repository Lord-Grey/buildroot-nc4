################################################################################
#
# umediaserver
#
################################################################################

UMEDIASERVER_VERSION = af89f8ac3355027a90d7b299a78fb6fab9b6ffca
UMEDIASERVER_SITE = $(call github,webosose,umediaserver,$(UMEDIASERVER_VERSION))
UMEDIASERVER_INSTALL_STAGING = YES
UMEDIASERVER_SUPPORTS_IN_SOURCE_BUILD = NO

UMEDIASERVER_DEPENDENCIES = \
	host-pkgconf \
	host-swig \
	cmake-modules-webos \
	libpbnjson \
	luna-service2 \
	libglib2 \
	libconfig \
	boost \
	gstreamer1 \
	sqlite \
	python3

define UMEDIASERVER_LINK_CMAKE_MODULES
	ln -snf $(STAGING_DIR)/usr/local/webos/Modules/webOS $(@D)/webOS
endef

UMEDIASERVER_PRE_CONFIGURE_HOOKS += UMEDIASERVER_LINK_CMAKE_MODULES

UMEDIASERVER_CFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54
UMEDIASERVER_CXXFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54

UMEDIASERVER_CONF_OPTS += \
	-DCMAKE_POLICY_DEFAULT_CMP0053=OLD \
	-DCMAKE_MODULE_PATH=$(STAGING_DIR)/usr/local/webos/Modules \
	-DCMAKE_C_FLAGS="$(UMEDIASERVER_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(UMEDIASERVER_CXXFLAGS)" \
	-DUSE_AVOUTPUTD=ON \
	-DWEBOS_INSTALL_ROOT=/

$(eval $(cmake-package))
