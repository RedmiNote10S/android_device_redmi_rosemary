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

# Android Go Networking Stack

# We're using these packages so that we have the proper packages that
# won't clash with signing instead of regular ones that are half-working
# and causing signature failures on manually signed builds.

# These might also improve performance and stability a bit better since
# Android Go devices already build these instead of their legacy/APEX
# variants. See "Do not spin up a separate process for the network
# stack on go devices, use an in-process APK." section in
# build/make/target/product/go_defaults.mk for more info.

PRODUCT_PACKAGES += \
    InProcessNetworkStack \
    CellBroadcastAppPlatform \
    CellBroadcastServiceModulePlatform \
    InProcessTethering
