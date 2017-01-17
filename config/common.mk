PRODUCT_BRAND ?= Reaper

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Default sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Titania.ogg \
    ro.config.notification_sound=Tethys.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/reaper/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/reaper/prebuilt/common/bin/50-reaper.sh:system/addon.d/50-reaper.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# REAPER-specific init file
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/etc/init.local.rc:root/init.reaper.rc

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/reaper/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/reaper/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/reaper/prebuilt/common/bin/sysinit:system/bin/sysinit

# debug packages
ifneq ($(TARGET_BUILD_VARIENT),user)
PRODUCT_PACKAGES += \
    Development
endif

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    ReaperBootAnimation \
    ReaperWallpapers \
    LatinIME \
    BluetoothExt \
    masquerade
    
# Adaway
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/app/AdAway/adaway.apk:system/app/adaway.apk    

# NovaLauncher 
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/app/NovaLauncher.apk:system/app/NovaLauncher/NovaLauncher.apk
    
# Reaper Kernelauditor
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/app/ReaperKA/ReaperKernelAdiutor.apk:system/app/ReaperKernelAdiutor/ReaperKernelAdiutor.apk
    
# Substratum
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/app/Substratum/Substratum.apk:system/app/Substratum/Substratum.apk 

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# easy way to extend to add more packages
-include vendor/extra/product.mk

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/reaper/overlay/common \
    vendor/reaper/overlay/dictionaries
    
# Bootanimation
ifeq ($(TARGET_BOOTANIMATION_480P),true)
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/media/bootanimation-480p.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/reaper/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip
endif    

# ReaperOS freeze code
ifeq ($(OFFICIAL),true)
BUILD_TYPE = OFFICIAL
else
ifeq ($(MILESTONE),true)
BUILD_TYPE = MILESTONE
else
ifeq ($(EXPERIMENTAL),true)
BUILD_TYPE = EXPERIMENTAL
else
ifeq ($(FINAL),true)
BUILD_TYPE = FINAL
else
BUILD_TYPE = UNSUPPORTED
endif
endif
endif
endif
PRODUCT_VERSION_MAJOR = 7.1.1
PRODUCT_VERSION_MINOR = build
PRODUCT_VERSION_MAINTENANCE = v.5
REAPER_BUILD_TYPE = $(BUILD_TYPE)
REAPER_POSTFIX := -$(shell date +"%Y%m%d")

ifeq ($(BUILD_TYPE),OFFICIAL)
    PLATFORM_VERSION_CODENAME := OFFICIAL
endif
ifeq ($(BUILD_TYPE),MILESTONE)
    PLATFORM_VERSION_CODENAME := MILESTONE
endif
ifeq ($(BUILD_TYPE),EXPERIMENTAL)
    PLATFORM_VERSION_CODENAME := EXPERIMENTAL
endif
ifeq ($(BUILD_TYPE),FINAL)
    PLATFORM_VERSION_CODENAME := FINAL
endif
ifeq ($(BUILD_TYPE),UNSUPPORTED)
    PLATFORM_VERSION_CODENAME := UNSUPPORTED
endif

ifdef REAPER_BUILD_EXTRA
    REAPER_POSTFIX := -$(REAPER_BUILD_EXTRA)
endif

# Set all versions
REAPER_VERSION := Reaper-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(REAPER_BUILD_TYPE)$(REAPER_POSTFIX)
REAPER_MOD_VERSION := Reaper-$(REAPER_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(REAPER_BUILD_TYPE)$(REAPER_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    reaper.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.reaper.version=$(REAPER_VERSION) \
    ro.modversion=$(REAPER_MOD_VERSION) \
    ro.reaper.buildtype=$(REAPER_BUILD_TYPE)

#EXTENDED_POST_PROCESS_PROPS := vendor/reaper/tools/reaper_process_props.py

