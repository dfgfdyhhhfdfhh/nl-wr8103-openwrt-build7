# NL-WR8103 OpenWrt build (build #7 — PHY fix)

OpenWrt firmware for the **Newland NL-WR8103** (China Unicom, MT7981B + MT7976CN,
256 MB RAM, SPI-NAND flash), built with GitHub Actions from
[hanimeia/openwrt](https://github.com/hanimeia/openwrt) (contains PR #19006
device support), pinned to the snapshot build #6 used
(commit `66de6c0809`, 2025-06-03).

- Target: `mediatek/filogic`, device `newland_nl-wr8103`
  (NOT the `-ubootmod` variant — this router uses the stock bootloader).
- No LuCI (SSH/CLI only); extra packages: `curl`, `htop`.
- Produces: `openwrt-mediatek-filogic-newland_nl-wr8103-initramfs-factory.ubi`
  (flash via U-Boot recovery first) and
  `openwrt-mediatek-filogic-newland_nl-wr8103-squashfs-sysupgrade.bin`
  (install from a running OpenWrt with `sysupgrade -n`).

## Build #7 change (the whole point of this rebuild)

Build #6 booted but the LAN switch never came up — no Ethernet link on any
of the 3 LAN ports (the link was UP in U-Boot, so the hardware and cable are
fine). The CPU-port link (GMAC0 ↔ switch port 6) was configured as
phy-mode `2500base-x` with fixed-link 2500 in
`mt7981b-newland_nl-wr8103-common.dtsi`. Build #7 changes both ends of that
link to phy-mode `sgmii` with fixed-link speed 1000, full-duplex.

Everything else is identical to build #6: same source snapshot, same config.

## Files

- `.github/workflows/build-openwrt.yml` — GitHub Actions build workflow.
- `diy-part1.sh` — pins the source to commit `66de6c0809`.
- `diy-part2.sh` — installs the fixed device-tree include, removes the
  WR9103 device (its `.dtsi` is missing from the tree).
- `nl-wr8103-openwrt.config` — build config.
- `mt7981b-newland_nl-wr8103-common.dtsi` — fixed device-tree include.
- `feeds.conf.default` — feeds (same pins as build #6).

Pushing to `main` (or Run workflow) starts a build; the firmware is uploaded
as the `OpenWrt_firmware_newland_nl-wr8103_*` artifact.
