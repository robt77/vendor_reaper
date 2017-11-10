$(call inherit-product, device/motorola/falcon/full_falcon.mk)

# Boot animation
TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1280

# Inherit some common Broken stuff.
include vendor/reaper/configs/reaper_phone.mk
PRODUCT_DEVICE := falcon
PRODUCT_NAME := falcon
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := Moto G
PRODUCT_MANUFACTURER := motorola
PRODUCT_GMS_CLIENTID_BASE := android-motorola
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=falcon PRODUCT_NAME=falcon
TARGET_VENDOR := Motorola
BOARD_USES_QCOM_HARDWARE := true

#Reaper Device Maintainers
PRODUCT_BUILD_PROP_OVERRIDES += \
DEVICE_MAINTAINERS="Rob Thompson (robt77)"

