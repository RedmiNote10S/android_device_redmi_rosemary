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

# Inherit device tree
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Common PE configs
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)
TARGET_SUPPORTS_GOOGLE_RECORDER := true
TARGET_INCLUDE_STOCK_ARCORE := true
TARGET_INCLUDE_LIVE_WALLPAPERS := true
TARGET_SUPPORTS_CALL_RECORDING := true
TARGET_USES_AOSP_RECOVERY := true

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
    PRIVATE_BUILD_DESC="rosemary-user 12 SP1A.210812.016 V13.0.8.0.SKLMIXM release-keys" \
    PRODUCT_NAME=rosemary

BUILD_FINGERPRINT := Redmi/rosemary_global/rosemary:12/SP1A.210812.016/V13.0.8.0.SKLMIXM:user/release-keys

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

