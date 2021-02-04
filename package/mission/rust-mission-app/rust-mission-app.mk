###############################################
#
# Rust Mission App example Build
#
###############################################

RUST_MISSION_APP_POST_BUILD_HOOKS += RUST_MISSION_APP_BUILD_CMDS
RUST_MISSION_APP_INSTALL_STAGING = YES
RUST_MISSION_APP_POST_INSTALL_STAGING_HOOKS += RUST_MISSION_APP_INSTALL_STAGING_CMDS
RUST_MISSION_APP_POST_INSTALL_TARGET_HOOKS += RUST_MISSION_APP_INSTALL_TARGET_CMDS
RUST_MISSION_APP_POST_INSTALL_TARGET_HOOKS += RUST_MISSION_APP_INSTALL_INIT_SYSV

define RUST_MISSION_APP_BUILD_CMDS
	cd $(BUILD_DIR)/mission-$(MISSION_VERSION)/apps/rust-mission-app && \
	PATH=$(PATH):~/.cargo/bin:/usr/bin/iobc_toolchain/usr/bin && \
	OPENSSL_LIB_DIR=$(BUILD_DIR)/libopenssl-$(LIBOPENSSL_VERSION) \
	OPENSSL_INCLUDE_DIR=$(BUILD_DIR)/libopenssl-$(LIBOPENSSL_VERSION)/include \
	CC=$(TARGET_CC) RUSTFLAGS="-Clinker=$(TARGET_CC)" cargo build --package rust-mission-app --target $(CARGO_TARGET) --release
endef

# Generate the config settings for the service and add them to a fragment file
define RUST_MISSION_APP_INSTALL_STAGING_CMDS
	echo '[rust-mission-app.addr]' > $(MISSION_CONFIG_FRAGMENT_DIR)/rust-mission-app
	echo 'ip = ${BR2_RUST_MISSION_APP_IP}' >> $(MISSION_CONFIG_FRAGMENT_DIR)/rust-mission-app
	echo -e 'port = ${BR2_RUST_MISSION_APP_PORT}\n' >> $(MISSION_CONFIG_FRAGMENT_DIR)/rust-mission-app
endef

# Install the application into the rootfs file system
define RUST_MISSION_APP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/sbin
	PATH=$(PATH):~/.cargo/bin:$(HOST_DIR)/usr/bin && \
	arm-linux-strip $(BUILD_DIR)/mission-$(MISSION_VERSION)/apps/rust-mission-app/$(CARGO_OUTPUT_DIR)/rust-mission-app
	$(INSTALL) -D -m 0755 $(BUILD_DIR)/mission-$(MISSION_VERSION)/apps/rust-mission-app/$(CARGO_OUTPUT_DIR)/rust-mission-app \
		$(TARGET_DIR)/usr/sbin
		
	echo 'CHECK PROCESS rust-mission-app PIDFILE /var/run/rust-mission-app.pid' > $(TARGET_DIR)/etc/monit.d/rust-mission-app.cfg
	echo '	START PROGRAM = "/etc/init.d/S${BR2_RUST_MISSION_APP_INIT_LVL}rust-mission-app start"' >> $(TARGET_DIR)/etc/monit.d/rust-mission-app.cfg
	echo '	IF ${BR2_RUST_MISSION_APP_RESTART_COUNT} RESTART WITHIN ${BR2_RUST_MISSION_APP_RESTART_CYCLES} CYCLES THEN TIMEOUT' \
	>> $(TARGET_DIR)/etc/monit.d/rust-mission-app.cfg
endef

# Install the init script
define RUST_MISSION_APP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_KUBOS_LINUX_PATH)/package/mission/rust-mission-app/rust-mission-app \
		$(TARGET_DIR)/etc/init.d/S$(BR2_RUST_MISSION_APP_INIT_LVL)rust-mission-app
endef

$(eval $(virtual-package))
