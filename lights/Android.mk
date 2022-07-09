LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := android.hardware.lights-service.mediatek
LOCAL_MODULE_TAGS  := optional

LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/bin
LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_SRC_FILES := \
    main.cpp \
    Lights.cpp

LOCAL_C_INCLUDES := \
    hardware/libhardware/include

LOCAL_SHARED_LIBRARIES := \
    libbinder_ndk \
    libhardware \
    liblog \
    android.hardware.light-ndk_platform

LOCAL_STATIC_LIBRARIES := \
    libbase

include $(BUILD_EXECUTABLE)
