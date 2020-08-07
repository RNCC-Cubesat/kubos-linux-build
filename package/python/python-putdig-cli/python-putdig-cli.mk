################################################################################
#
# python-putdig-cli
#
################################################################################

PYTHON_PUTDIG_CLI_VERSION = 0.0.5
PYTHON_PUTDIG_CLI_SOURCE = PuTDIG-CLI-$(PYTHON_PUTDIG_CLI_VERSION).tar.gz
PYTHON_PUTDIG_CLI_SITE = https://files.pythonhosted.org/packages/19/b7/0e5a4fef76aa3b10071da51c3833149ea8a68b0b94855000936d2fbd98b3
PYTHON_PUTDIG_CLI_SETUP_TYPE = setuptools
PYTHON_PUTDIG_CLI_LICENSE = MIT

$(eval $(python-package))
