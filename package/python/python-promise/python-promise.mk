################################################################################
#
# python-promise
#
################################################################################

PYTHON_PROMISE_VERSION = 2.3
PYTHON_PROMISE_SOURCE = promise-$(PYTHON_PROMISE_VERSION).tar.gz
PYTHON_PROMISE_SITE = https://files.pythonhosted.org/packages/cf/9c/fb5d48abfe5d791cd496e4242ebcf87a4bb2e0c3dcd6e0ae68c11426a528
PYTHON_PROMISE_SETUP_TYPE = setuptools
PYTHON_PROMISE_LICENSE = MIT

$(eval $(python-package))
