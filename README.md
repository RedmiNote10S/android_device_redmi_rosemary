# Device Tree Status
Initial works: https://github.com/RedmiNote10S/android_device_redmi_rosemary/issues/1

Additions by [@akshat0011](https://github.com/akshat0011): IMS stuff

My additions;
- [x] Done initial Kasumi bringup for further works on a personally pleasing environment.
- [x] Fixed bootability. Last commit: https://github.com/windowz414/android_device_redmi_rosemary/commit/e2ad72b7bccc70287230d7c39aef8dd3343bc6f7
- [x] Checked for basic features and determined full list of bugs.
- [x] Fixed offline charging. First and last commit: https://github.com/windowz414/android_device_redmi_rosemary/commit/731b5afaf11b2f179d50bc6894e6182f5e3c10f1
- [x] Fixed headphone and Bluetooth audio. Possible commit: https://github.com/windowz414/android_device_redmi_rosemary/commit/a819a19c2faf1f2c8712f7b978ba91ad53deefdb
- [ ] Fixing IMS...
- [ ] Will try to enable AOD without hacks.
- [ ] Will try to fix DT2W regardless of AOD status.
- [ ] Will **BLINDLY** try to fix NFC. Secret doesn't have it.
- [ ] Will port GSI workarounds from PHH Treble without patching actual ROM sources.
- [ ] Will work on making MIUI Camera available on all ROMs regardless - Dirty hack but necessary for all lenses to work.
- [ ] Will attempt to make OSS vendor instead of prebuilt MIUI one here.
- [ ] (If previous fails) Will turn current MIUI vendor.img into a regular vendor tree.

Device Tree for Redmi Note 10s (rosemary)
==========================================

The Redmi Note 10s (codenamed _"rosemary"_) is a high-end, mid-range smartphone from Xiaomi.


| Basic                   | Spec Sheet                                                                                                                     |
| -----------------------:|:------------------------------------------------------------------------------------------------------------------------------ |
| CPU                     | Octa-core                                                                                                                      |
| Chipset                 | Mediatek Helio G95                                                                                                            |
| GPU                     | Mali-G76 MC4                                                                                                                   |
| Memory                  | 6/8 GB RAM                                                                                                                     |
| Shipped Android Version | 11.0                                                                                                                           |
| Storage                 | 64/128 GB                                                                                                              |
| Battery                 | Non-removable Li-Po 5000 mAh battery                                                                                           |
| Display                 | 1080 x 2400 pixels, 19.5:9 ratio (~440 ppi density)                                                                            |
| Camera (Back)(Main)     | 64MP + 8MP + 2MP + 2MP                                                                                |
| Camera (Front)          | 13MP                                                                                                     |

## Device picture
![rosemary](https://i01.appmifile.com/webfile/globalimg/Anna/rn10s_Blue.png)

## Credits
[@erfanoabdi](https://github.com/erfanoabdi), [@J6idot](https://github.com/J6idot), [@akshat0011](https://github.com/akshat0011), [@Woomymy](https://github.com/Woomymy), [@dgigantino](https://github.com/dgigantino), [@gaganmalvi](https://github.com/gaganmalvi), Aylin, and many more who helped with the development for Redmi Note 10S
