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
sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

# 默认网关 ip 地址修改
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 修改 wifi 无线名称
sed -i "s/LiBwrt/OpenWrt/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 wifi 无线名称 & 密码
sed -i "s/BASE_SSID='.*'/BASE_SSID='OpenWrt'/g" target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
sed -i "s/BASE_WORD='.*'/BASE_WORD='password'/g" target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh

# 最大连接数修改为65535
# sed -i "s/nf_conntrack_max=.*/nf_conntrack_max=65535/g" package/kernel/linux/files/sysctl-nf-conntrack.conf
# sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# 修改 luci 文件，添加 NSS Load 相关状态显示
# sed -i "s#const fd = popen('top -n1 | awk \\\'/^CPU/ {printf(\"%d%\", 100 - \$8)}\\\'')#const fd = popen(access('/sbin/cpuinfo') ? '/sbin/cpuinfo' : \"top -n1 | awk \\'/^CPU/ {printf(\"%d%\", 100 - \$8)}\\'\")#g"

# 修改 wifi 默认打开
# sed -i "s/disabled='${defaults ? 0 : 1}'/disabled='0'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 更换 KERNEL 内核版本
# sed -i "s/KERNEL_PATCHVER:=6.6/KERNEL_PATCHVER:=6.1/g" target/linux/qualcommax/Makefile

# samba 解除 root 限制
# sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# 调整插件显示位置
# sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-eqos/root/usr/share/luci/menu.d/luci-app-eqos.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-wol/root/usr/share/luci/menu.d/luci-app-wol.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-wifischedule/root/usr/share/luci/menu.d/luci-app-wifischedule.json

# 取消 bootstrap 为默认主题，添加 argon 主题设置为默认
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 更新 golang 依赖（ mosdns & alist 插件 )
# rm -rf feeds/packages/lang/golang
# git clone --depth=1 -b 23.x https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# 替换 geodata 依赖
# rm -rf feeds/packages/net/v2ray-geodata
# git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# AdguardHome
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
git clone --depth=1 https://github.com/TanZhiwen2001/luci-app-adguardhome package/luci-app-adguardhome
# git clone --depth=1 -b lua https://github.com/sirpdboy/luci-app-adguardhome package/luci-app-adguardhome
# git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
git clone --depth=1 -b v5 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

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
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall

# nikki
git clone --depth=1 -b main https://github.com/nikkinikki-org/OpenWrt-nikki.git package/luci-app-nikki

# nekobox
# git clone --depth=1 https://github.com/Thaolga/openwrt-nekobox.git package/openwrt-nekobox

# neko
# git clone --depth=1 https://github.com/nosignals/openwrt-neko.git package/openwrt-neko

# alist
# rm -rf feeds/packages/net/alist
# rm -rf feeds/luci/applications/luci-app-alist
# git clone --depth=1 https://github.com/sbwml/luci-app-alist package/luci-app-alist

# jdCloud ax6600 led screen ctrl
# git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led

# filemanager
# git clone --depth=1 https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager

./scripts/feeds update -a
./scripts/feeds install -a
