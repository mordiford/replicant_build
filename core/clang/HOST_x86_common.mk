# Shared by HOST_x86.mk and HOST_x86_64.mk.

ifeq ($(HOST_OS),darwin)
CLANG_CONFIG_x86_DARWIN_HOST_EXTRA_ASFLAGS := \
  -integrated-as

CLANG_CONFIG_x86_DARWIN_HOST_EXTRA_CFLAGS := \
  -integrated-as
endif

ifeq ($(HOST_OS),linux)
CLANG_CONFIG_x86_LINUX_HOST_EXTRA_ASFLAGS := \
  --gcc-toolchain=toolchain/gcc/host/install

CLANG_CONFIG_x86_LINUX_HOST_EXTRA_CFLAGS := \
  --gcc-toolchain=toolchain/gcc/host/install \
  -isystem toolchain/headers/clang

ifneq ($(strip $($(clang_2nd_arch_prefix)HOST_IS_64_BIT)),)
CLANG_CONFIG_x86_LINUX_HOST_EXTRA_CPPFLAGS := \
  --gcc-toolchain=toolchain/gcc/host/install \
  -isystem toolchain/headers/clang

CLANG_CONFIG_x86_LINUX_HOST_EXTRA_LDFLAGS := \
  --gcc-toolchain=toolchain/gcc/host/install \
  -Btoolchain/gcc/host/install/x86_64-linux/bin \
  -Btoolchain/gcc/host/install/lib/gcc/x86_64-linux/4.9 \
  -Ltoolchain/gcc/host/install/lib/gcc/x86_64-linux/4.9 \
  -Ltoolchain/gcc/host/install/lib64

else

CLANG_CONFIG_x86_LINUX_HOST_EXTRA_CPPFLAGS := \
  --gcc-toolchain=toolchain/gcc/host/install \
  -isystem toolchain/headers/clang

CLANG_CONFIG_x86_LINUX_HOST_EXTRA_LDFLAGS := \
  --gcc-toolchain=toolchain/gcc/host/install \
  -Btoolchain/gcc/host/install/x86_64-linux/bin \
  -Btoolchain/gcc/host/install/lib/gcc/x86_64-linux/4.9/32 \
  -Ltoolchain/gcc/host/install/lib/gcc/x86_64-linux/4.9/32 \
  -Ltoolchain/gcc/host/install/lib32

endif
endif  # Linux

ifeq ($(HOST_OS),windows)
# nothing required here yet
endif
