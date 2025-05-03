#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改 device 设备名称
# sed -i "s/LibWrt/OpenWrt/g" package/base-files/files/bin/config_generate

# 默认网关 ip 地址修改
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 修改 wifi 无线名称
# sed -i "s/LiBwrt/OpenWrt/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 加入作者信息
# sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt-$(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings   
# sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By J.Y'/g" package/lean/default-settings/files/zzz-default-settings

# sed -i "2iuci set istore.istore.channel='OpenWrt'" package/lean/default-settings/files/zzz-default-settings
# sed -i "3iuci commit istore" package/lean/default-settings/files/zzz-default-settings

# 清除默认密码password
# sed -i '/V4UetPzk$CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# 最大连接数修改为 65535
# sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# 更换 KERNE 内核
# sed -i "s/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=6.6/g" target/linux/qualcommax/Makefile

# 更换 bin 固件内核大小
# sed -i "s/factory.bin recovery.bin/factory.bin sysupgrade.bin/g" target/linux/qualcommax/image/ipq60xx.mk
# sed -i "s/pad-to 12288k/pad-to 6144k/g" target/linux/qualcommax/image/ipq60xx.mk

# samba 解除 root 限制
# sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# 取消 bootstrap 为默认主题，添加 argon 主题设置为默认
rm -rf feeds/luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 添加 kucat 主题，搭配 luci-app-advancedplus 设置参数 
# git clone -b js https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat

# 添加 advanced 系统设置插件
# git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# git clone https://github.com/sirpdboy/luci-app-advancedplus.git package/luci-app-advancedplus

# 删除自带 AdguardHome 文件，添加 AdguardHome 广告过滤插件
rm -rf feeds/packages/net/adguardhome
# rm -rf feeds/luci/applications/luci-app-adguardhome
# git clone https://github.com/xptsp/luci-app-adguardhome package/luci-app-adguardhome
# git clone https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# 更新 golang 依赖（ mosdns & alist )
# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# 替换 geodata 依赖
# rm -rf feeds/packages/net/v2ray-geodata
# git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns

# smartdns
# rm -rf feeds/packages/net/smartdns
# rm -rf feeds/luci/applications/luci-app-smartdns
# git clone https://github.com/pymumu/openwrt-smartdns.git  feeds/packages/net/smartdns
# git clone https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns

# nekobox
# git clone https://github.com/Thaolga/openwrt-nekobox.git package/openwrt-nekobox

# neko
# git clone --depth=1 https://github.com/nosignals/openwrt-neko.git -b main package/openwrt-neko

# nikki
# git clone https://github.com/nikkinikki-org/OpenWrt-nikki.git package/luci-app-nikki
# git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki.git -b main package/luci-app-nikki

# openclash（ dev 版 ）
rm -rf feeds/luci/applications/luci-app-openclash
# git clone -b dev https://github.com/vernesong/OpenClash.git package/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git -b dev package/luci-app-openclash

# passwall(2)
rm -rf feeds/luci/applications/luci-app-passwall
# rm -rf feeds/luci/applications/luci-app-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall
# git clone https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/luci-app-passwall

# alist
# rm -rf feeds/packages/net/alist
# rm -rf feeds/luci/applications/luci-app-alist
# git clone https://github.com/sbwml/luci-app-alist package/luci-app-alist

# filemanager（ 文件管理 ）
# git clone https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager
# git clone https://github.com/muink/luci-app-tinyfilemanager package/luci-app-tinyfilemanager

# jdCloud ax6600 led screen ctrl
# git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led

./scripts/feeds update -a
./scripts/feeds install -a
