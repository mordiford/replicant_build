LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

LOCAL_SRC_FILES:= \
    CopyFile.c

ifeq ($(HOST_OS),cygwin)
LOCAL_CFLAGS += -DWIN32_EXE
endif
ifeq ($(HOST_OS),darwin)
LOCAL_CFLAGS += -DMACOSX_RSRC
endif
ifeq ($(HOST_OS),linux)
endif

LOCAL_MODULE:= libhost
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

# acp uses libhost, so we can't use
# acp to install libhost.
LOCAL_ACP_UNAVAILABLE:= true

LOCAL_ADDRESS_SANITIZER := false

include $(BUILD_HOST_STATIC_LIBRARY)

# Include toolchain prebuilt modules if they exist.
-include $(TARGET_TOOLCHAIN_ROOT)/toolchain.mk

# prebuilt java libraries from host machines
include $(CLEAR_VARS)

LOCAL_PREBUILT_JAVA_LIBRARIES := \
    asm-tools:asm$(COMMON_JAVA_PACKAGE_SUFFIX) \
    asm-4.0$(COMMON_JAVA_PACKAGE_SUFFIX) \
    guava-tools:guava$(COMMON_JAVA_PACKAGE_SUFFIX) \
    org-netbeans-api-visual$(COMMON_JAVA_PACKAGE_SUFFIX) \
    org-openide-util$(COMMON_JAVA_PACKAGE_SUFFIX) \
    org-openide-util-lookup$(COMMON_JAVA_PACKAGE_SUFFIX) \
    kxml2-2.3.0$(COMMON_JAVA_PACKAGE_SUFFIX) \
    tools-common-prebuilt$(COMMON_JAVA_PACKAGE_SUFFIX)

LOCAL_MODULE_TAGS := optional

include $(BUILD_HOST_PREBUILT)


include $(CLEAR_VARS)

LOCAL_MODULE := ddmlib-prebuilt
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := ddmlib-prebuilt.jar
LOCAL_IS_HOST_MODULE := true
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_BUILT_MODULE_STEM := javalib.jar
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)
