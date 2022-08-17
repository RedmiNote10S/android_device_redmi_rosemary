PRODUCT_MAKEFILES := \
	$(LOCAL_DIR)/lineage_rosemary.mk

COMMON_LUNCH_CHOICES := \
    $(foreach variant, user userdebug eng, lineage_rosemary-$(variant))
