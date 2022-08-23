#
# Copyright (C) 2022 Beru Hinode
#
# SPDX-License-Identifier: GPL-2.0-only
#

# Interchangeable Overlays

# This is a generic config you can use on your device with necessary
# changes. The key is that there might be some overlays that can be
# unified into a single folder and built on-demand depending on which
# package is built (Especially when a platform enforces updatable package
# whereas you specified to build InProcess package). OEMs usually prefer
# to ship both of the overlays, which takes even 1-2 MB off the partition
# built overlay is installed into. Since some platforms are too bloated
# (E.g. shipping too many apps/customization overlays to provide the full
# functionality they promise for), we're using an if-else statement to
# determine which type of package we're building, and finally build the
# overlay we need.

# Keep in mind that overlays that are required to be built regardless must
# rather exist on your device.mk, they don't belong here.

# NetworkStack
ifeq ($(strip InProcessNetworkStack,$(PRODUCT_PACKAGES)),)
    PRODUCT_PACKAGES += NetworkStackOverlayRosemary
else
    PRODUCT_PACKAGES += NetworkStackInProcessOverlayRosemary
endif
