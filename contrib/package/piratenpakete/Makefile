# 
# Copyright (C) 2006-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=piratenpakete
PKG_RELEASE:=1
PKG_SOURCE_URL:=@SF/piratenpakete


PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/piratenpakete
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Freifunk
  TITLE:=Non-standard packages for piratenfreifunknodes
  URL:=http://wiki.piratenpartei.de/BE:Squads/Piratenfreifunk
  DEPENDS:= \
    +horst +tcpdump \
    +wprobe-export \
    +luci-app-ddns +luci-app-firewall +luci-app-initmgr +luci-app-ntpc +luci-app-p2pblock +luci-app-qos \
    +luci-freifunk-community +luci-theme-piraten +piratendefaults +remote-update 
endef


#    +kmod-usb-core +kmod-usb-net +kmod-usb-ohci +kmod-usb2 \
#    +kmod-rt73-usb +kmod-zd1211rw \


#    +wprobe-export \  # I guess this one causes the crc-ccitt compile ERROR
#    +usbutils \
#    +kmod-ipip +kmod-tun \
#    +kmod-usb-core +kmod-usb-ohci +kmod-usb-uhci +kmod-usb2 \
#    +kmod-usb-net +kmod-p54-usb +kmod-rt2500-usb +kmod-rt2800-usb \
#    +kmod-rt73-usb +kmod-rtl8187  +kmod-zd1211rw\

#  KCONFIG:=CONFIG_KERNEL_KALLSYMS CONFIG_GDB


define Package/piratenpakete/description
 Addons like tcpdump, ip, wget to pull minimum set of tools into
 an embedded device image
endef



$(eval $(call BuildPackage,piratenpakete))
