/*
 * Copyright (C) 2019 The Android Open Source Project
 * Copyright (C) 2020-2021 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.lights-service.mediatek"

#include "Lights.h"
#include <android-base/file.h>
#include <android-base/logging.h>

namespace {

/* clang-format off */
#define PPCAT_NX(A, B) A/B
#define PPCAT(A, B) PPCAT_NX(A, B)
#define STRINGIFY_INNER(x) #x
#define STRINGIFY(x) STRINGIFY_INNER(x)

#define LEDS(x) PPCAT(/sys/class/leds, x)
#define LCD_ATTR(x) STRINGIFY(PPCAT(LEDS(lcd-backlight), x))
/* clang-format on */

using ::android::base::ReadFileToString;
using ::android::base::WriteStringToFile;

// Default max brightness
constexpr auto kDefaultMaxLedBrightness = 2047;

// Write value to path and close file.
bool WriteToFile(const std::string& path, uint32_t content) {
    return WriteStringToFile(std::to_string(content), path);
}

uint32_t RgbaToBrightness(uint32_t color) {
    uint32_t alpha, red, green, blue;

    /*
     * Extract brightness from AARRGGBB.
     */
    alpha = (color >> 24) & 0xFF;
    red = (color >> 16) & 0xFF;
    green = (color >> 8) & 0xFF;
    blue = color & 0xFF;

    /*
     * Scale RGB brightness using Alpha brightness.
     */
    red = red * alpha / 0xFF;
    green = green * alpha / 0xFF;
    blue = blue * alpha / 0xFF;

    return (77 * red + 150 * green + 29 * blue) >> 8;
}

}  // anonymous namespace

namespace aidl {
namespace android {
namespace hardware {
namespace light {

Lights::Lights() {
    std::map<int, std::function<void(int id, const HwLightState&)>> lights_{
        {(int)LightType::BACKLIGHT, [this](auto&&... args) { setLightBacklight(args...); }}
    };

    std::vector<HwLight> availableLights;
    for (auto const& pair : lights_) {
        int id = pair.first;
        HwLight hwLight{};
        hwLight.id = id;
        availableLights.emplace_back(hwLight);
    }
    mAvailableLights = availableLights;
    mLights = lights_;

    std::string buf;

    if (ReadFileToString(LCD_ATTR(max_brightness), &buf)) {
        max_screen_brightness_ = std::stoi(buf);
    } else {
        max_screen_brightness_ = kDefaultMaxLedBrightness;
        LOG(ERROR) << "Failed to read max screen brightness, fallback to " << kDefaultMaxLedBrightness;
    }
}

ndk::ScopedAStatus Lights::setLightState(int id, const HwLightState& state) {
    auto it = mLights.find(id);
    if (it == mLights.end()) {
        LOG(ERROR) << "Light not supported";
        return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
    }

    it->second(id, state);

    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus Lights::getLights(std::vector<HwLight>* lights) {
    for (auto i = mAvailableLights.begin(); i != mAvailableLights.end(); i++) {
        lights->push_back(*i);
    }
    return ndk::ScopedAStatus::ok();
}

void Lights::setLightBacklight(int /* id */, const HwLightState& state) {
    int brightness = RgbaToBrightness(state.color);
    int scaledBrightness = (brightness - 1) * (max_screen_brightness_ - 1) / (0xFF - 1) + 1;
    LOG(INFO) << "Using non-scaled: " << brightness;
    LOG(INFO) << "Using scaled: " << scaledBrightness;
    WriteToFile(LCD_ATTR(brightness), scaledBrightness);
}
}  // namespace light
}  // namespace hardware
}  // namespace android
}  // namespace aidl
