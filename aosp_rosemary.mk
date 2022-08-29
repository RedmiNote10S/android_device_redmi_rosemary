#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Common AOSP base
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common LineageOS stuff.
CUSTOM_VENDOR_DIR ?= vendor/aosp
$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/common_full_phone.mk)

# Inherit device tree
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Ship Google Camera GO by default
$(call inherit-product, $(GCGOP_VENDOR_DIR)/config.mk)

# GApps
TARGET_GAPPS_ARCH := arm64

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

PRODUCT_NAME := aosp_rosemary
PRODUCT_DEVICE := rosemary
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := rosemary

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="rosemary-user 11 RP1A.200720.011 V12.5.16.0.RKLMIXM release-keys" \
    PRODUCT_NAME=rosemary

BUILD_FINGERPRINT := Redmi/rosemary/rosemary:11/RP1A.200720.011/V12.5.16.0.RKLMIXM:user/release-keys

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
