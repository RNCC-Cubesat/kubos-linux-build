#####################################################
#
# Example Python Mission App installation
#
#####################################################
PYTHON_MISSION_APP_VERSION = 0.0.1
PYTHON_MISSION_APP_LICENSE = Apache-2.0
PYTHON_MISSION_APP_LICENSE_FILES = LICENSE
PYTHON_MISSION_APP_SITE = $(BUILD_DIR)/mission-$(MISSION_VERSION)/apps/python-mission-app
PYTHON_MISSION_APP_SITE_METHOD = local
PYTHON_MISSION_APP_DEPENDENCIES = kubos
PYTHON_MISSION_APP_SETUP_TYPE = setuptools

PYTHON_MISSION_APP_INSTALL_STAGING = YES
PYTHON_MISSION_APP_POST_INSTALL_STAGING_HOOKS += PUMPKIN_MCU_INSTALL_STAGING_CMDS

# Generate the config settings for the service and add them to a fragment file
define PUMPKIN_MCU_INSTALL_STAGING_CMDS
	echo '[python-mission-app.addr]' > $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
	echo 'ip = ${BR2_PYTHON_MISSION_APP_IP}' >> $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
	echo 'port = ${BR2_PYTHON_MISSION_APP_PORT}' >> $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
	echo '' >> $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
	echo '[python-mission-app]' >> $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
	echo 'string_var = ${BR2_PYTHON_MISSION_APP_STRING_VAR}' >> $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
	echo '' >> $(MISSION_CONFIG_FRAGMENT_DIR)/python-mission-app
endef

# Install the init script
define PYTHON_MISSION_APP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_KUBOS_LINUX_PATH)/package/mission/python-mission-app/python-mission-app \
		$(TARGET_DIR)/etc/init.d/S$(BR2_PYTHON_MISSION_APP_INIT_LVL)python-mission-app
endef

$(eval $(python-package))
