#
# Copyright (C) 2022 Beru Hinode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

# Tethering
ifeq ($(strip InProcessTethering,$(PRODUCT_PACKAGES)),)
    PRODUCT_PACKAGES += TetheringOverlayRosemary
else
    PRODUCT_PACKAGES += InProcessTetheringOverlayRosemary
endif
