################################################################################
#
# python-waitress
#
################################################################################

PYTHON_WAITRESS_VERSION = 1.4.4
PYTHON_WAITRESS_SOURCE = waitress-$(PYTHON_WAITRESS_VERSION).tar.gz
PYTHON_WAITRESS_SITE = https://files.pythonhosted.org/packages/9a/32/90a74e5ab5fd4fa4bd051a51eb9a8f63bbbf3e00a00dc5cf73ebd4ddb46a
PYTHON_WAITRESS_SETUP_TYPE = setuptools
PYTHON_WAITRESS_LICENSE = MIT

$(eval $(python-package))
