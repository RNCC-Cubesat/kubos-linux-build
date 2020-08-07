################################################################################
#
# python-putdig-common
#
################################################################################

PYTHON_PUTDIG_COMMON_VERSION = 0.2.0
PYTHON_PUTDIG_COMMON_SOURCE = putdig-common-$(PYTHON_PUTDIG_COMMON_VERSION).tar.gz
PYTHON_PUTDIG_COMMON_SITE = https://files.pythonhosted.org/packages/bf/76/2ceefb6b7a7b0c7e3eabfe658799a803bd69ef7be411c24f65063fd4b8b9
PYTHON_PUTDIG_COMMON_SETUP_TYPE = setuptools
PYTHON_PUTDIG_COMMON_LICENSE = MIT

$(eval $(python-package))
