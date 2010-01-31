#
# Copyright (C) 2009 Jo-Philipp Wich <xm@subsignal.org>
#
# This is free software, licensed under the Apache 2.0 license.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=piratenheartbeat
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/piratenheartbeat
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Freifunk
  TITLE:=pirate party heartbeat.
  DEPENDS:=\
  +node-id
endef

define Package/piratenheartbeat/description
  Heartbeatscript which sends position, version, node-id, hostname, landesverband and crew\
  to a server to implement highscores, etc. Place your conspiracy in http://github.com/alxhh/piratenluci/issues \
  or on the "aktiven" mailingliste, which i do not read anyway.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/piratenheartbeat/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,piratenheartbeat))
