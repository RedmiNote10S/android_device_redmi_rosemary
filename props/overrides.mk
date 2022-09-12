#
# Copyright (C) 2022 Beru Hinode
#
# SPDX-License-Identifier: GPL-2.0-only
#

# Property overrides wherever needed

# System props
PRODUCT_SYSTEM_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=log

# Vendor props
PRODUCT_VENDOR_PROPERTY_OVERRIDES += \
    vendor.debug.sf.latch_unsignaled=0
