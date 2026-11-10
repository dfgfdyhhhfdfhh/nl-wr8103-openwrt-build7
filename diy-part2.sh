#!/bin/bash
# diy-part2.sh — NL-WR8103 build #7 (PHY fix)
# Runs inside the openwrt source dir, after the config is in place.
#
# 1. Install our fixed device-tree include. The hanimeia tree is missing
#    mt7981-newland-nl-wr8103.dtsi entirely (the .dts includes it), so the
#    kernel dtbs build would fail without it. The copy below is our
#    reconstruction with the build #7 PHY fix: CPU-port link (gmac0 and
#    switch port 6) changed from phy-mode "2500base-x" + fixed-link 2500
#    to phy-mode "sgmii" + fixed-link 1000, because build #6 booted but the
#    LAN switch never came up (no Ethernet link on any LAN port).
cp "$GITHUB_WORKSPACE/mt7981b-newland_nl-wr8103-common.dtsi" target/linux/mediatek/dts/mt7981-newland-nl-wr8103.dtsi

# 2. Remove the WR9103 device. Its .dtsi is also missing from the tree, so
#    the kernel dtbs build fails on its .dts files. Delete the .dts files and
#    their image definitions in filogic.mk (WR8103 blocks are untouched).
rm -f target/linux/mediatek/dts/mt7981-newland-nl-wr9103.dts target/linux/mediatek/dts/mt7981-newland-nl-wr9103-ubootmod.dts
sed -i '/^define Device\/newland_nl-wr9103$/,/^TARGET_DEVICES += newland_nl-wr9103 $/d' target/linux/mediatek/image/filogic.mk
sed -i '/^define Device\/newland_nl-wr9103-ubootmod$/,/^TARGET_DEVICES += newland_nl-wr9103-ubootmod$/d' target/linux/mediatek/image/filogic.mk
