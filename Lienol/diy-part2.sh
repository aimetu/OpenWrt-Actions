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
# sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

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

# rust 滥用报错
# sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' feeds/packages/lang/rust/Makefile

# 调整插件显示位置
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
sed -i 's/services/control/g' feeds/luci/applications/luci-app-wol/root/usr/share/luci/menu.d/luci-app-wol.json
sed -i 's/services/control/g' feeds/luci/applications/luci-app-wifischedule/root/usr/share/luci/menu.d/luci-app-wifischedule.json

# 取消 bootstrap 为默认主题，添加 argon 主题设置为默认
rm -rf feeds/luci/themes/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# git clone --depth=1 -b openwrt-24.10 https://github.com/sbwml/luci-theme-argon package/luci-theme-argon

# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 更新 golang 依赖（ mosdns & alist )
# rm -rf feeds/packages/lang/golang
# git clone --depth=1 -b 23.x https://github.com/sbwml/packages_lang_golang.git feeds/packages/lang/golang

# 替换 geodata 依赖
# rm -rf feeds/packages/net/v2ray-geodata
# git clone --depth=1 https://github.com/sbwml/v2ray-geodata.git package/v2ray-geodata

# adguardhome
rm -rf feeds/other/luci-app-adguardhome
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
git clone --depth=1 -b lua https://github.com/sirpdboy/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone --depth=1 -b main https://github.com/xptsp/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
git clone --depth=1 -b v5 https://github.com/sbwml/luci-app-mosdns.git package/luci-app-mosdns

# smartdns
# rm -rf feeds/packages/net/smartdns
# rm -rf feeds/luci/applications/luci-app-smartdns
# git clone --depth=1 https://github.com/pymumu/openwrt-smartdns.git package/smartdns
# git clone --depth=1 https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# OpenClash（ dev 版 ）
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 -b dev https://github.com/vernesong/OpenClash.git package/luci-app-openclash
# git clone -b dev https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# passwall(2)
# rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/packages/net/shadowsocks-libev
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall

# homeproxy
rm -rf feeds/luci/applications/luci-app-homeproxy
git clone --depth=1 -b dev https://github.com/immortalwrt/homeproxy.git package/luci-app-homeproxy

# nikki
# git clone --depth=1 -b main https://github.com/nikkinikki-org/OpenWrt-nikki.git package/luci-app-nikki

# nekobox
# git clone --depth=1 -b main https://github.com/Thaolga/openwrt-nekobox.git package/openwrt-nekobox

# neko
# git clone --depth=1-b main https://github.com/nosignals/openwrt-neko.git package/openwrt-neko

# daed
# rm -rf feeds/packages/net/daed
# rm -rf feeds/luci/applications/luci-app-daed
# git clone --depth=1 -b main https://github.com/QiuSimons/luci-app-daed.git package/luci-app-daed

# alist
# rm -rf feeds/packages/net/alist
# rm -rf feeds/luci/applications/luci-app-alist
# git clone --depth=1 -b main https://github.com/sbwml/luci-app-alist.git package/luci-app-alist

# jdCloud ax6600 led screen ctrl
# git clone --depth=1 -b main https://github.com/NONGFAH/luci-app-athena-led.git package/luci-app-athena-led

# filemanager
# git clone --depth=1 -b main https://github.com/sbwml/luci-app-filemanager.git package/luci-app-filemanager

# 修复 jdCloud ax6600 无限重启
rm -rf package/kernel/mac80211/patches/nss/ath11k/999-900-bss-transition-handling.patch

# 修复 rust 报错
# sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' feeds/packages/lang/rust/Makefile

./scripts/feeds update -a
./scripts/feeds install -a
