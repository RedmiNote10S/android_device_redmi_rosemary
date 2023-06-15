#
# Copyright (C) 2020 The PixelExperience Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/redmi/rosemary

# Inherit virtual_ab_ota product
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/redmi/rosemary/rosemary-vendor.mk)

$(call inherit-product, vendor/mediatek/opensource/mtk-builds.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Include Dev GSI Keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# A/B
PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# API level, the device has been commercially launched on
PRODUCT_SHIPPING_API_LEVEL := 30

# APNs
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/apns-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# Additional Build Props
# Usually fingerprint, codename and hostname changes rolling around here.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/props/sku/system/rosemary.build.prop:$(TARGET_COPY_OUT_SYSTEM)/rosemary.build.prop \
    $(LOCAL_PATH)/props/sku/system/secret.build.prop:$(TARGET_COPY_OUT_SYSTEM)/secret.build.prop \
    $(LOCAL_PATH)/props/sku/system/maltose.build.prop:$(TARGET_COPY_OUT_SYSTEM)/maltose.build.prop \
    $(LOCAL_PATH)/props/sku/product/rosemary.build.prop:$(TARGET_COPY_OUT_PRODUCT)/rosemary.build.prop \
    $(LOCAL_PATH)/props/sku/product/secret.build.prop:$(TARGET_COPY_OUT_PRODUCT)/secret.build.prop \
    $(LOCAL_PATH)/props/sku/product/maltose.build.prop:$(TARGET_COPY_OUT_PRODUCT)/maltose.build.prop \
    $(LOCAL_PATH)/props/sku/vendor/rosemary.build.prop:$(TARGET_COPY_OUT_VENDOR)/rosemary.build.prop \
    $(LOCAL_PATH)/props/sku/vendor/secret.build.prop:$(TARGET_COPY_OUT_VENODR)/secret.build.prop \
    $(LOCAL_PATH)/props/sku/vendor/maltose.build.prop:$(TARGET_COPY_OUT_VENDOR)/maltose.build.prop \
    $(LOCAL_PATH)/props/sku/odm/rosemary.build.prop:$(TARGET_COPY_OUT_VENDOR)/odm/etc/rosemary.build.prop \
    $(LOCAL_PATH)/props/sku/odm/secret.build.prop:$(TARGET_COPY_OUT_VENODR)/odm/etc/secret.build.prop \
    $(LOCAL_PATH)/props/sku/odm/maltose.build.prop:$(TARGET_COPY_OUT_VENDOR)/odm/etc/maltose.build.prop \
    $(LOCAL_PATH)/props/sku/system_ext/rosemary.build.prop:$(TARGET_COPY_OUT_SYSTEM_EXT)/rosemary.build.prop \
    $(LOCAL_PATH)/props/sku/system_ext/secret.build.prop:$(TARGET_COPY_OUT_SYSTEM_EXT)/secret.build.prop \
    $(LOCAL_PATH)/props/sku/system_ext/maltose.build.prop:$(TARGET_COPY_OUT_SYSTEM_EXT)/maltose.build.prop

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.service.mediatek \
    android.hardware.audio@6.0-impl \
    android.hardware.audio@6.0-impl-mediatek \
    android.hardware.audio.effect@6.0-impl \
    android.hardware.audio@5.0.vendor \
    android.hardware.audio@7.0.vendor \
    android.hardware.audio@7.0-impl \
    android.hardware.bluetooth.audio-impl \
    android.hardware.broadcastradio@1.0.vendor \
    android.hardware.broadcastradio@1.1.vendor \
    android.hardware.broadcastradio@2.0.vendor \
    android.hardware.bluetooth@1.0.vendor \
    audio.primary.default \
    audio.r_submix.default \
    audio_policy.stub \
    audio.usb.default \
    audio.bluetooth.default \
    tinymix \
    libaudiopreprocessing \
    libtinyxml \
    libalsautils \
    libtinycompress \
    libaudiofoundation \
    libaudiofoundation.vendor \
    libdynproc \
    libbluetooth_audio_session \
    libldacBT_enc \
    libldacBT_abr \
    vendor.mediatek.hardware.audio@6.1.vendor

PRODUCT_COPY_FILES += \
    prebuilts/vndk/v30/arm64/arch-arm-armv8-a/shared/vndk-core/libmedia_helper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmedia_helper-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm64-armv8-a/shared/vndk-core/libmedia_helper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmedia_helper-v30.so

PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(DEVICE_PATH)/configs/audio/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# CAS
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.device@3.2.vendor \
    android.hardware.camera.device@3.3.vendor \
    android.hardware.camera.device@3.4.vendor \
    android.hardware.camera.device@3.5.vendor \
    android.hardware.camera.device@3.6.vendor \
    android.hardware.camera.provider@2.4 \
    android.hardware.camera.provider@2.4.vendor \
    android.hardware.camera.provider@2.5.vendor \
    android.hardware.camera.provider@2.6.vendor \
    vendor.mediatek.hardware.camera.atms@1.0.vendor \
    vendor.mediatek.hardware.camera.bgservice@1.0.vendor \
    vendor.mediatek.hardware.camera.bgservice@1.1.vendor \
    vendor.mediatek.hardware.camera.frhandler@1.0.vendor \
    vendor.mediatek.hardware.camera.isphal@1.0.vendor \
    vendor.mediatek.hardware.camera.postproc@1.0.vendor \
    vendor.mediatek.hardware.camera.lomoeffect@1.0.vendor

PRODUCT_COPY_FILES += \
    prebuilts/vndk/v30/arm64/arch-arm64-armv8-a/shared/vndk-sp/libunwindstack.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libunwindstack-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm64-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libutils-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm-armv8-a/shared/vndk-sp/libunwindstack.so:$(TARGET_COPY_OUT_VENDOR)/lib/libunwindstack-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutils-v30.so

# Charger
PRODUCT_PACKAGES += \
    android.hardware.health@2.0 \
    android.hardware.health@2.1-impl \
    libsuspend

# Common NFC
PRODUCT_PACKAGES += \
    SecureElement \
    Tag \
    com.android.nfc_extras \
    libchrome \
    libchrome.vendor \
    android.hardware.nfc@1.2-service.st \
    NfcNci \
    android.hardware.nfc@1.2-service.st.rc

# Consumerir
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-service \
    android.hardware.ir@1.0-service.xiaomi \
    android.hardware.ir@1.0-impl

# DRM
PRODUCT_PACKAGES += \
    libdrm.vendor \
    android.hardware.drm@1.3.vendor \
    android.hardware.drm@1.2.vendor \
    android.hardware.drm@1.1.vendor \
    android.hardware.drm@1.0.vendor

# DRM, but bad
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey \
    libclearkeycasplugin.vendor \
    libdrmclearkeyplugin.vendor \
    libmockdrmcryptoplugin

# Display
PRODUCT_PACKAGES += \
    android.frameworks.displayservice@1.0.vendor \
    libhwc2on1adapter \
    libhwc2onfbadapter \
    libfmq

# Dynamic partitions
PRODUCT_BUILD_SUPER_PARTITION := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/excluded-input-devices.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/excluded-input-devices.xml

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0.vendor

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.0.vendor \
    android.hardware.gnss@2.1.vendor

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.composer@2.1-resources \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl \
    vendor.mediatek.hardware.gpu@1.0.vendor \
    vendor.mediatek.hardware.mms@1.5.vendor

# HIDL and HW binder
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0.vendor \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl

# IMS
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    ImsServiceBase \
    ImsInit \
    PresencePolling \
    RcsService \
    vendor.mediatek.hardware.videotelephony@1.0.vendor \
    vendor.mediatek.hardware.videotelephony@1.0

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/public.libraries-trustonic.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries-trustonic.txt

# Init
PRODUCT_PACKAGES += \
    init.mediatek.rc

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-fpc.kl \
    $(DEVICE_PATH)/configs/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-goodix.kl

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0.vendor \
    android.hardware.keymaster@4.1.vendor \
    android.hardware.keymaster@4.0.vendor \
    libkeymaster4support.vendor:64 \
	libkeymaster4_1support.vendor:64 \
	libsoft_attestation_cert.vendor:64 \
    libkeymaster4.vendor:64 \
    vendor.mediatek.hardware.keyinstall@1.0.vendor \
    vendor.mediatek.hardware.keymaster_attestation@1.0.vendor \
    vendor.mediatek.hardware.keymaster_attestation@1.1.vendor

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

# LBS
PRODUCT_PACKAGES += \
    vendor.mediatek.hardware.lbs@1.0.vendor

# Light
PRODUCT_PACKAGES += \
    android.hardware.lights-service.mediatek

# Local time
PRODUCT_PACKAGES += \
    local_time.default

# Media
PRODUCT_PACKAGES += \
    libmedia_codeclist \
    libstagefright_codecbase \
    libstagefright_bufferpool@2.0.1 \
    libstagefright_framecapture_utils \
    libstagefright_softomx_plugin \
    vendor.mediatek.hardware.mtkcodecservice@1.1.vendor

PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(DEVICE_PATH)/configs/media/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

PRODUCT_COPY_FILES += \
    $(foreach xml, google_audio, \
        frameworks/av/media/libstagefright/data/media_codecs_$(xml).xml:$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, media_codecs_$(xml).xml))

# MLIPay
PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.mlipay@1.0.vendor \
    vendor.xiaomi.hardware.mlipay@1.1.vendor

# MTK In-Call volumes adjusting service
PRODUCT_PACKAGES += \
    MtkInCallService

# Mtkperf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/vendor/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Networking
PRODUCT_PACKAGES += \
    libpcap \
    libpcap.vendor

# NeuralNet
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor \
    android.hardware.neuralnetworks@1.2.vendor \
    android.hardware.neuralnetworks@1.1.vendor \
    android.hardware.neuralnetworks@1.0.vendor \
    libtextclassifier_hash.vendor

# NGA
PRODUCT_PACKAGES += \
    NgaResources \
    nga

# NVRAM
PRODUCT_PACKAGES += \
    vendor.mediatek.hardware.nvram@1.1.vendor

# Other MTK Interfaces
PRODUCT_PACKAGES += \
    vendor.mediatek.hardware.dfps@1.0.vendor \
    vendor.mediatek.hardware.nwk_opt@1.0.vendor

# Overlays
PRODUCT_PACKAGES += \
    FrameworksResOverlayRosemary \
    GoogleNetworkStackOverlayRosemary \
    SettingsOverlayRosemary \
    SystemUIOverlayRosemary \
    TelephonyOverlayRosemary \
    TetheringOverlayRosemary \
    WifiOverlayRosemary

DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay-aosp

# Overridden props
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true
include $(DEVICE_PATH)/props/overrides.mk

# Perf configs
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(DEVICE_PATH)/configs/perf/*), \
        $(file):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(file))) )

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    $(DEVICE_PATH)/configs/permissions/android.hardware.microphone.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.microphone.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-imsinit.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-imsinit.xml \
    $(DEVICE_PATH)/configs/permissions/com.fingerprints.extension.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.fingerprints.extension.xml \
    $(DEVICE_PATH)/configs/permissions/com.google.android.feature.PREMIER_TIER.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.google.android.feature.PREMIER_TIER.xml \
    $(DEVICE_PATH)/configs/permissions/com.mediatek.hardware.vow_dsp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.mediatek.hardware.vow_dsp.xml \
    $(DEVICE_PATH)/configs/permissions/com.mediatek.hardware.vow.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.mediatek.hardware.vow.xml \
    $(DEVICE_PATH)/configs/permissions/com.mediatek.ims.plugin.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.mediatek.ims.plugin.xml \
    $(DEVICE_PATH)/configs/permissions/com.mediatek.op.ims.common.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.mediatek.op.ims.common.xml \
    $(DEVICE_PATH)/configs/permissions/com.mediatek.wfo.legacy.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.mediatek.wfo.legacy.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_rosemary/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_rosemary/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_rosemary/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_rosemary/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_rosemary/android.hardware.se.omapi.uicc.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0.vendor \
    android.hardware.power@1.1.vendor \
    android.hardware.power@1.2.vendor \
    android.hardware.power@1.3.vendor \
    android.hardware.power-V1-ndk_platform.vendor \
    vendor.mediatek.hardware.power@1.1.vendor \
    vendor.mediatek.hardware.power@2.0.vendor \
    vendor.mediatek.hardware.mtkpower@1.0.vendor \
    vendor.mediatek.hardware.mtkpower@1.1.vendor \
    android.hardware.power.stats-service.example

# PQ
PRODUCT_PACKAGES += \
    vendor.mediatek.hardware.pq@2.6.vendor

# Ramdisk
PRODUCT_PACKAGES += \
    init.ago.rc \
    init.mt6785.rc \
    init.sensor_1_0.rc \
    fstab.mt6785 \
    init.connectivity.rc \
    init.mt6785.usb.rc \
    init.project.rc \
    init.stnfc.rc \
    init.modem.rc \
    vendor.ueventd.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6785:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6785

# RenderScript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# RIL
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1.vendor \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio@1.4.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    android.hardware.secure_element@1.2.vendor \
    android.hardware.secure_element@1.1.vendor \
    android.hardware.secure_element@1.0.vendor \
    vendor.mediatek.hardware.netdagent@1.0.vendor

# Sensors
PRODUCT_PACKAGES += \
    android.frameworks.sensorservice@1.0 \
    android.frameworks.sensorservice@1.0.vendor \
    android.hardware.sensors@2.0-ScopedWakelock.vendor \
    android.hardware.sensors@2.0.vendor \
    android.hardware.sensors@2.1-service.multihal \
    libsensorndkbridge

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/xiaomi

# SoundTrigger
PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.0-impl \
    android.hardware.soundtrigger@2.3-impl

# Symbols
PRODUCT_PACKAGES += \
    libshim_vtservice \
    libshim_beanpod.vendor \
    libshim_showlogo

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0.vendor

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0.vendor \
    android.hardware.usb@1.1.vendor \
    android.hardware.usb.gadget@1.0.vendor \
    android.hardware.usb.gadget@1.1.vendor

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 32

# VNDService
PRODUCT_PACKAGES += \
    vndservice_manager \
    vndservice_manager.vendor

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.rosemary

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service-lazy.rosemary \
    android.hardware.wifi.supplicant@1.0.vendor \
    android.hardware.wifi.supplicant@1.1.vendor \
    android.hardware.wifi.supplicant@1.2.vendor \
    android.hardware.wifi.supplicant@1.3.vendor \
    android.hardware.wifi.supplicant@1.4.vendor \
    android.hardware.wifi.hostapd@1.0.vendor \
    android.hardware.wifi.hostapd@1.1.vendor \
    android.hardware.wifi.hostapd@1.2.vendor \
    android.hardware.wifi.hostapd@1.3.vendor \
    libkeystore-engine-wifi-hidl \
    libkeystore-wifi-hidl \
    hostapd \
    wpa_supplicant
