# Infinitive-OS RELEASE VERSION
IO_VERSION_MAJOR = 0
IO_VERSION_MINOR = 1
IO_VERSION_MAINTENANCE = alpha
IO_BRANCH=n

VERSION := $(IO_VERSION_MAJOR).$(IO_VERSION_MINOR)-$(IO_VERSION_MAINTENANCE)

ifndef IO_BUILDTYPE
    ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^IO_||g')
        IO_BUILDTYPE := $(RELEASE_TYPE)
    else
        IO_BUILDTYPE := UNOFFICIAL
    endif
endif

ifdef IO_BUILDTYPE
    ifeq ($(IO_BUILDTYPE), RELEASE)
       IO_VERSION := $(TARGET_PRODUCT)_$(IO_BRANCH)-$(VERSION)-RELEASE-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(IO_BUILDTYPE), NIGHTLY)
        IO_VERSION := $(TARGET_PRODUCT)_$(IO_BRANCH)-$(VERSION)-NIGHTLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(IO_BUILDTYPE), EXPERIMENTAL)
        IO_VERSION := $(TARGET_PRODUCT)_$(IO_BRANCH)-$(VERSION)-EXPERIMENTAL-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(IO_BUILDTYPE), UNOFFICIAL)
        IO_VERSION := $(TARGET_PRODUCT)_$(IO_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
    endif
else
#We reset back to UNOFFICIAL
        IO_VERSION := $(TARGET_PRODUCT)_$(IO_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(IO_VERSION) \
    ro.io.version=$(VERSION)-$(IO_BUILDTYPE)
