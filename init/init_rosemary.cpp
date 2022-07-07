/*
   Copyright (c) 2015, The Linux Foundation. All rights reserved.
   Copyright (C) 2016 The CyanogenMod Project.
   Copyright (C) 2019 The LineageOS Project.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <fstream>
#include <string.h>
#include <sys/sysinfo.h>
#include <unistd.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include <android-base/properties.h>
#include "property_service.h"
#include "vendor_init.h"

using android::base::GetProperty;
using android::base::SetProperty;
using std::string;

void property_override(string prop, string value) {
    auto pi = (prop_info*) __system_property_find(prop.c_str());

    if (pi != nullptr)
        __system_property_update(pi, value.c_str(), value.size());
    else
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
}

void vendor_load_properties() {
    string sku = GetProperty("ro.boot.product.hardware.sku", "");
    string device;
    string name;
    string fingerprint;

    if (sku == "secret") {
        device = "secret";
        name = "secret_global";
        fingerprint = "Redmi/secret_global/secret:11/RP1A.200720.011/V12.5.16.0.RKLMIXM:user/release-keys";
    } else if (sku == "maltose") {
        device = "maltose";
        name = "maltose_global";
        fingerprint = "Redmi/maltose_global/maltose:11/RP1A.200720.011/V12.5.16.0.RKLMIXM:user/release-keys";
    } else {
        device = "rosemary";
        name = "rosemary_global";
        fingerprint = "Redmi/rosemary_global/rosemary:11/RP1A.200720.011/V12.5.16.0.RKLMIXM:user/release-keys";
    }

    // Debug
    if (sku == "merlinnfc") {
        device = "merlinnfc";
        name = "merlinnfc_global";
        fingerprint = "Redmi/merlinnfc_global/merlinnfc:11/RP1A.200720.011/V12.5.2.0.RJOMIXM:user/release-keys";

        property_override("ro.build.description", "merlinnfc-user 11 RP1A.200720.011  release-keys");
    }

    string prop_partitions[] = { "", "odm.", "product.", "system.", "system_ext.", "vendor.", "bootimage." };
    for (const string &prop : prop_partitions) {
        property_override(string("ro.product.") + prop + string("device"), device);
        property_override(string("ro.product.") + prop + string("name"), name);
        property_override(string("ro.") + prop + string("build.fingerprint"), fingerprint);
    }
}
