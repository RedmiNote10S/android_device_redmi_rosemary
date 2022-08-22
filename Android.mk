#
# Copyright (C) 2021 The PixelExperience Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),rosemary)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)

VENDOR_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib64/hw \
	$(TARGET_OUT_VENDOR)/lib/hw

$(VENDOR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Creating gatekeeper/vulkan symlinks"
	@mkdir -p $(TARGET_OUT_VENDOR)/lib64/hw
	@mkdir -p $(TARGET_OUT_VENDOR)/lib/hw
	@ln -sfv libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so
	@ln -sfv libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.default.so
	@ln -sfv ../egl/libGLES_mali.so $(TARGET_OUT_VENDOR)/lib/hw/vulkan.mt6785.so
	@ln -sfv ../egl/libGLES_mali.so $(TARGET_OUT_VENDOR)/lib64/hw/vulkan.mt6785.so
	$(hide) touch $@

ALL_DEFAULT_INSTALLED_MODULES += $(VENDOR_SYMLINKS)

endif
