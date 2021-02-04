###############################################
#
# Kubos Master Package
#
# This package downloads the Kubos repo,
# globally links all the modules, and sets the
# target for the subsequent Kubos child 
# packages
#
###############################################
MISSION_LICENSE = Apache-2.0
MISSION_LICENSE_FILES = LICENSE
# Link to .tar.gz download of source on GitLab
MISSION_SITE = https://gitlab.com/pumpkin-space-systems/public/mission-apps/-/archive/master
#MISSION_PROVIDES = mission-mai400
MISSION_INSTALL_STAGING = YES
MISSION_TARGET_FINALIZE_HOOKS += MISSION_CREATE_CONFIG

MISSION_CONFIG_FRAGMENT_DIR = $(STAGING_DIR)/etc/mission
MISSION_CONFIG_FILE = $(TARGET_DIR)/etc/mission-config.toml

VERSION = $(call qstrip,$(BR2_MISSION_VERSION))
# If the version specified is a branch name, we need to go fetch the SHA1 for the branch's HEAD
ifeq ($(shell git ls-remote --heads $(MISSION_SITE) $(VERSION) | wc -l), 1)
	# GitHub Version
	#MISSION_VERSION := $(shell git ls-remote $(MISSION_SITE) $(VERSION) | cut -c1-8)
	# GitLab Version
	MISSION_VERSION = $(VERSION)
else
	MISSION_VERSION = $(VERSION)
endif

# TODO: Make target work on multiple different boards.
#MISSION_BR_TARGET = $(lastword $(subst /, ,$(dir $(BR2_LINUX_KERNEL_CUSTOM_DTS_PATH))))
#ifeq ($(MISSION_BR_TARGET),at91sam9g20isis)
#	MISSION_TARGET = kubos-linux-isis-gcc
#	CARGO_TARGET = armv5te-unknown-linux-gnueabi
#else ifeq ($(MISSION_BR_TARGET),pumpkin-mbm2)
#	MISSION_TARGET = kubos-linux-pumpkin-mbm2-gcc
#	CARGO_TARGET = arm-unknown-linux-gnueabihf
#else ifeq ($(MISSION_BR_TARGET),beaglebone-black)
#	MISSION_TARGET = kubos-linux-beaglebone-gcc
#	CARGO_TARGET = arm-unknown-linux-gnueabihf
#else
#	MISSION_TARGET = unknown
#endif

MISSION_TARGET = kubos-linux-pumpkin-mbm2-gcc
CARGO_TARGET = arm-unknown-linux-gnueabihf

CARGO_OUTPUT_DIR = target/$(CARGO_TARGET)/release

define MISSION_INSTALL_STAGING_CMDS
	mkdir -p $(MISSION_CONFIG_FRAGMENT_DIR)
endef

define MISSION_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/monit.d
endef

define MISSION_CREATE_CONFIG
	# Collect all config fragment files into the final master config.toml file
	cat $(MISSION_CONFIG_FRAGMENT_DIR)/* > $(MISSION_CONFIG_FILE)
endef


mission-deepclean:
	rm -fR $(BUILD_DIR)/mission-*
	rm -f $(DL_DIR)/mission-*
	rm -f $(TARGET_DIR)/etc/init.d/*mission*
	rm -f $(TARGET_DIR)/etc/monit.d/*mission*
	rm -fR $(MISSION_CONFIG_FRAGMENT_DIR)
	rm -fR $(BUILD_DIR)/../staging/etc/mission
	rm -f $(MISSION_CONFIG_FILE)

mission-fullclean: mission-clean-for-reconfigure mission-dirclean
	rm -f $(BUILD_DIR)/mission-$(MISSION_VERSION)/.stamp_downloaded
	rm -f $(DL_DIR)/mission-$(MISSION_VERSION).tar.gz
	rm -fR $(MISSION_CONFIG_FRAGMENT_DIR)
	rm -fR $(BUILD_DIR)/../staging/etc/mission
	rm -f $(MISSION_CONFIG_FILE)

mission-clean: mission-clean-for-rebuild
	rm -fR $(BUILD_DIR)/mission-$(MISSION_VERSION)/target

$(eval $(generic-package))
