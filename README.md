# Miredo for OpenWRT

Currently this package is [under
review](https://github.com/openwrt/packages/pull/4201) to be included in the
OpenWRT packages repository.

## Building the package manually

- Obtain and unpack
  [OpenWRT SDK](https://wiki.openwrt.org/doc/howto/obtain.firmware.sdk) for
  your target platform.
- Change directory there, in `OpenWrt-SDK...`.
- Put these source files into `package/miredo`.
- Run `make`.
- The package is built in `packages/base/miredo_....ipk`.

## License

Copyright (C) 2017 Petr Pudlák

This is free software, licensed under the GNU General Public License v2.
See [/LICENSE](LICENSE) for more information.
