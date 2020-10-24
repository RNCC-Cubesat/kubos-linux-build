#####################################################
#
# Pumpkin MCU Python Service Installation
#
#####################################################
KUBOS_PUMPKIN_MCU_VERSION = 0.0.1
KUBOS_PUMPKIN_MCU_LICENSE = Apache-2.0
KUBOS_PUMPKIN_MCU_LICENSE_FILES = LICENSE
KUBOS_PUMPKIN_MCU_SITE = $(BUILD_DIR)/kubos-$(KUBOS_VERSION)/services/pumpkin-mcu-service
KUBOS_PUMPKIN_MCU_SITE_METHOD = local
KUBOS_PUMPKIN_MCU_DEPENDENCIES = kubos
KUBOS_PUMPKIN_MCU_SETUP_TYPE = setuptools

KUBOS_PUMPKIN_MCU_INSTALL_STAGING = YES
KUBOS_PUMPKIN_MCU_POST_INSTALL_STAGING_HOOKS += PUMPKIN_MCU_INSTALL_STAGING_CMDS

# Generate the config settings for the service and add them to a fragment file
define PUMPKIN_MCU_INSTALL_STAGING_CMDS
	echo '[pumpkin-mcu-service.addr]' > $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo 'ip = ${BR2_KUBOS_PUMPKIN_MCU_IP}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo 'port = ${BR2_KUBOS_PUMPKIN_MCU_PORT}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo '' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo '[pumpkin-mcu-service]' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo 'bus_path = ${BR2_KUBOS_PUMPKIN_MCU_BUS_PATH}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo 'i2c_type = "kubos"' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo 'i2c_port = 1' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
	echo '' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/pumpkin-mcu-service
endef

# Install the init script
define KUBOS_PUMPKIN_MCU_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_KUBOS_LINUX_PATH)/package/kubos/kubos-pumpkin-mcu/kubos-pumpkin-mcu \
		$(TARGET_DIR)/etc/init.d/S$(BR2_KUBOS_PUMPKIN_MCU_INIT_LVL)kubos-pumpkin-mcu

# Install the default bus definition json
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_KUBOS_LINUX_PATH)/package/kubos/kubos-pumpkin-mcu/bus.json \
		$(TARGET_DIR)/home/system/etc/bus.json

endef

$(eval $(python-package))
