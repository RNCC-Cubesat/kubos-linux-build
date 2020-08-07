################################################################################
#
# python-plumbum
#
################################################################################

PYTHON_PLUMBUM_VERSION = 1.6.9
PYTHON_PLUMBUM_SOURCE = plumbum-$(PYTHON_PLUMBUM_VERSION).tar.gz
PYTHON_PLUMBUM_SITE = https://files.pythonhosted.org/packages/bf/3c/3b78dd1c8f2221a1de78b09e89b92197349342bec3a95117faeaf07a1c7e
PYTHON_PLUMBUM_SETUP_TYPE = setuptools
PYTHON_PLUMBUM_LICENSE = MIT

$(eval $(python-package))
