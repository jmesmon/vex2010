ALL_CFLAGS  = $(ARCH_CFLAGS) $(CFLAGS)
ALL_LDFLAGS = $(ARCH_LDFLAGS) $(LDFLAGS)
ALL_ASFLAGS = $(ARCH_ASFLAGS) $(ASFLAGS)
ALL_MDFLAGS = $(ARCH_MDFLAGS) $(MDFLAGS)

# Use the path to this Makefile as the base directory of HAX.
srcdir     := $(dir $(lastword $(MAKEFILE_LIST)))
srcdir     := $(srcdir:/=)
ARCH        = $(srcdir)/arch_$(arch)
TARGET      = $(prog)-$(arch).$(ARCH_EXT)

.SUFFIXES:
.PHONY: all clean build rebuild

all: build

rebuild : | clean build

include $(ARCH)/build.mk

build: $(TARGET)

mrproper:
	@echo "MRPROPER"
	@$(FIND) . -print \
	| $(GREP) '.*\.\([od]\|elf\|hex\|bin\|map\|lss\|sym\|strip\)$$' \
	| $(XARGS) -- $(RM)

