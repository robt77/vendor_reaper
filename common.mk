# Substratum
PRODUCT_COPY_FILES += \
vendor/reaper/prebuilt/common/app/Substratum/Substratum.apk:system/app/Substratum/Substratum.apk

# masquerade
PRODUCT_COPY_FILES += \
vendor/reaper/prebuilt/common/app/masquerade/masquerade.apk:system/app/masquerade/masquerade.apk

# Bootanimation
ifeq ($(TARGET_BOOTANIMATION_480P),true)
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/media/bootanimation-480p.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip
endif

