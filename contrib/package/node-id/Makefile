#
# Copyright (C) 2009 Jo-Philipp Wich <xm@subsignal.org>
#
# This is free software, licensed under the Apache 2.0 license.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=node-id
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/node-id
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Freifunk
  TITLE:=NodeId
endef

define Package/node-id/description
  generates node id once
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/node-id/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,node-id))
