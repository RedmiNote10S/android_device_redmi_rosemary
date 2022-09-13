PRODUCT_MAKEFILES := \
	$(LOCAL_DIR)/kscope_rosemary.mk

COMMON_LUNCH_CHOICES := \
    $(foreach variant, user userdebug eng, kscope_rosemary-$(variant))
