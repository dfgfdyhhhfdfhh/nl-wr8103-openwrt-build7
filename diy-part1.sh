#!/bin/bash
# diy-part1.sh — NL-WR8103 build #7 (PHY fix)
# Runs inside the openwrt source dir, before feeds are updated.
#
# Pin the source to the exact snapshot build #6 used, so the only difference
# from build #6 is the device-tree PHY fix in diy-part2.sh:
#   hanimeia/openwrt main at 2025-06-03, commit 66de6c0809
# (snapshot r29938-66de6c0809, kernel 6.6.92).
git checkout 66de6c0809ce20f8cfc3728f889490898973d5e3
