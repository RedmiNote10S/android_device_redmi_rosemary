#
# Copyright (C) 2020 The PixelExperience Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/redmi/rosemary

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
    system \
    product \
    vendor \
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

# API level, the device has been commercially launched on
PRODUCT_SHIPPING_API_LEVEL := 30

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-mtkimpl \
    android.hardware.boot@1.1-mtkimpl.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Dynamic partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 30

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Keylayout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-fpc.kl \
    $(DEVICE_PATH)/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-goodix.kl

# Mtkperf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/vendor/public.libraries.txt:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/public.libraries.txt

# Common NFC
PRODUCT_PACKAGES += \
    SecureElement \
    Tag \
    com.android.nfc_extras

# NfcNci
PRODUCT_PACKAGES += \
    NfcNci

# NQNfcNci
#PRODUCT_PACKAGES += \
#    NQNfcNci \
#    libnqnfc-nci \
#    libnqnfc_nci_jni \
#    libsn100nfc_nci_jni \
#    libsn100nfc-nci \
#    com.nxp.nfc.nq \
#    com.nxp.nfc.nq.xml

# Light
PRODUCT_PACKAGES += \
    android.hardware.lights-service.mediatek

# Init
PRODUCT_PACKAGES += \
    init.mediatek.rc

# Trust HAL
PRODUCT_PACKAGES += \
    lineage.trust@1.0-service

# Overlays
PRODUCT_PACKAGES += \
    RosemaryFrameworks \
    RosemaryTelephony \
    MerlinFrameworks \
    MerlinTelephony

# Props
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/props/build_rosemary.prop:$(TARGET_COPY_OUT_SYSTEM)/build_rosemary.prop \
    $(LOCAL_PATH)/props/build_merlinnfc.prop:$(TARGET_COPY_OUT_SYSTEM)/build_merlinnfc.prop

# RCS
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)
