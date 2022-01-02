#
# Copyright (C) 2020 The PixelExperience Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/rosemary

# Inherit virtual_ab_ota product
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    product \
    system \
    vbmeta \
    vbmeta_system

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-lineage

# RRO (Runtime Resource Overlay)
PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(DEVICE_PATH)/overlay-lineage/packages/apps/Snap
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(DEVICE_PATH)/overlay/packages/apps/CarrierConfig

# API level, the device has been commercially launched on
PRODUCT_SHIPPING_API_LEVEL := 30

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-mtkimpl.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Ramdisk
PRODUCT_PACKAGES += \
    factory_init.connectivity.rc \
    fstab.emmc \
    init.aee.rc \
    init.modem.rc \
    init.project.rc \
    meta_init.connectivity.rc \
    meta_init.rc \
    factory_init.project.rc \
    fstab.enableswap \
    init.ago.rc \
    init.mt6785.rc \
    init.sensor_1_0.rc \
    meta_init.modem.rc \
    multi_init.rc \
    factory_init.rc \
    fstab.mt6785 \
    init.connectivity.rc \
    init.mt6785.usb.rc \
    init.stnfc.rc \
    meta_init.project.rc \
    ueventd.mtk.rc

# Ramdisk For Kernel
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6785:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6785

# RCS
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.mt6785.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 30

# Inherit vendor
$(call inherit-product, vendor/xiaomi/rosemary/rosemary-vendor.mk)
