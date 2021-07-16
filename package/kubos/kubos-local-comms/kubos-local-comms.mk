###############################################
#
# Kubos Local Comms Service
#
###############################################

KUBOS_LOCAL_COMMS_DEPENDENCIES = kubos

KUBOS_LOCAL_COMMS_POST_BUILD_HOOKS += LOCAL_COMMS_BUILD_CMDS
KUBOS_LOCAL_COMMS_INSTALL_STAGING = YES
KUBOS_LOCAL_COMMS_POST_INSTALL_STAGING_HOOKS += LOCAL_COMMS_INSTALL_STAGING_CMDS
KUBOS_LOCAL_COMMS_POST_INSTALL_TARGET_HOOKS += LOCAL_COMMS_INSTALL_TARGET_CMDS
KUBOS_LOCAL_COMMS_POST_INSTALL_TARGET_HOOKS += LOCAL_COMMS_INSTALL_INIT_SYSV

define LOCAL_COMMS_BUILD_CMDS
	cd $(BUILD_DIR)/kubos-$(KUBOS_VERSION)/services/local-comms-service && \
	PATH=$(PATH):~/.cargo/bin:/usr/bin/iobc_toolchain/usr/bin && \
	PKG_CONFIG_ALLOW_CROSS=1 CC=$(TARGET_CC) RUSTFLAGS="-Clinker=$(TARGET_CC)" cargo build --package local-comms-service --target $(CARGO_TARGET) --release
endef

# Generate the config settings for the service and add them to a fragment file
define LOCAL_COMMS_INSTALL_STAGING_CMDS
	echo '[local-comms-service.addr]' > $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo 'ip = ${BR2_KUBOS_LOCAL_COMMS_IP}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo -e 'port = ${BR2_KUBOS_LOCAL_COMMS_PORT}\n' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo '[local-comms-service.comms]' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo 'ip = ${BR2_KUBOS_LOCAL_COMMS_COMMS_IP}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo 'max_num_handlers = ${BR2_KUBOS_LOCAL_COMMS_HANDLERS}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	# KConfig doesn't have a list type, so we're just going to take a string (ex. "[1, 2, 3]") and strip the quotes
	echo 'downlink_ports = $(patsubst "%",%,${BR2_KUBOS_LOCAL_COMMS_DOWNLINK_PORTS})' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo -e 'timeout = ${BR2_KUBOS_LOCAL_COMMS_TIMEOUT}\n' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo '[local-comms-service]' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo 'bus = ${BR2_KUBOS_LOCAL_COMMS_BUS}' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
	echo -e 'ping_freq = ${BR2_KUBOS_LOCAL_COMMS_PING}\n' >> $(KUBOS_CONFIG_FRAGMENT_DIR)/local-comms-service
endef

# Install the application into the rootfs file system
define LOCAL_COMMS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/sbin
	PATH=$(PATH):~/.cargo/bin:$(HOST_DIR)/usr/bin && \
	arm-linux-strip $(BUILD_DIR)/kubos-$(KUBOS_VERSION)/$(CARGO_OUTPUT_DIR)/local-comms-service
	$(INSTALL) -D -m 0755 $(BUILD_DIR)/kubos-$(KUBOS_VERSION)/$(CARGO_OUTPUT_DIR)/local-comms-service \
		$(TARGET_DIR)/usr/sbin
		
	echo 'CHECK PROCESS local-comms-service PIDFILE /var/run/local-comms-service.pid' > $(TARGET_DIR)/etc/monit.d/kubos-local-comms.cfg
	echo '	START PROGRAM = "/etc/init.d/S${BR2_KUBOS_LOCAL_COMMS_INIT_LVL}kubos-local-comms start"' >> $(TARGET_DIR)/etc/monit.d/kubos-local-comms.cfg 
	echo '	IF ${BR2_KUBOS_LOCAL_COMMS_RESTART_COUNT} RESTART WITHIN ${BR2_KUBOS_LOCAL_COMMS_RESTART_CYCLES} CYCLES THEN TIMEOUT' \
	>> $(TARGET_DIR)/etc/monit.d/kubos-local-comms.cfg
endef

# Install the init script
define LOCAL_COMMS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_KUBOS_LINUX_PATH)/package/kubos/kubos-local-comms/kubos-local-comms \
		$(TARGET_DIR)/etc/init.d/S$(BR2_KUBOS_LOCAL_COMMS_INIT_LVL)kubos-local-comms
endef

$(eval $(virtual-package))
