# Caveats:
#   - Make sure you have gawk, othwerise you get weird syntax errors.
#   - Install ccache, otherwise you'll get configure error:
#     C compiler cannot create executables
#   - Shared libraries are a pain, so just compile static.
include $(TOPDIR)/rules.mk

PKG_NAME:=miredo
PKG_VERSION:=1.2.6
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/miredo-$(PKG_VERSION)
PKG_SOURCE:=miredo-1.2.6.tar.xz
PKG_SOURCE_URL:=https://www.remlab.net/files/miredo/
PKG_SHA256SUM:=fa26d2f4a405415833669e2e2e22677b225d8f83600844645d5683535ea43149
PKG_CAT:=xzcat
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Petr Pudlak <petr.mvd@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/miredo
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Teredo IPv6 tunneling utility
	URL:=https://www.remlab.net/miredo/
	DEPENDS:=+libpthread +librt +ip +kmod-ipv6 +kmod-tun
endef

define Package/miredo/description
 Miredo is an open-source Teredo IPv6 tunneling software, for Linux and the BSD
 operating systems. It includes functional implementations of all components of
 the Teredo specification (client, relay and server). It is meant to provide
 IPv6 connectivity even from behind NAT devices.
endef

CONFIGURE_VARS += CFLAGS="$(TARGET_CFLAGS) -std=gnu99"

define Build/Configure
	$(call Build/Configure/Default,--with-pic --without-libiconv-prefix --without-libintl-prefix --without-Judy --enable-static --disable-shared)
endef

define Package/miredo/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/miredo $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/miredo-checkconf $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/miredo
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/miredo-privproc $(1)/usr/lib/miredo
	$(INSTALL_DIR) $(1)/etc/miredo
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/misc/miredo.conf $(1)/etc/miredo
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/misc/client-hook $(1)/etc/miredo
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/miredo.init $(1)/etc/init.d/miredo
endef

$(eval $(call BuildPackage,miredo))
