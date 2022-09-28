PRODUCT_MAKEFILES := \
	$(LOCAL_DIR)/aosp_rosemary.mk

COMMON_LUNCH_CHOICES := \
    $(foreach variant, user userdebug eng, aosp_rosemary-$(variant))
