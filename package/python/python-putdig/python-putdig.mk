################################################################################
#
# python-putdig
#
################################################################################

PYTHON_PUTDIG_VERSION = 0.0.1
PYTHON_PUTDIG_SOURCE = PuTDIG-$(PYTHON_PUTDIG_VERSION).tar.gz
PYTHON_PUTDIG_SITE = https://files.pythonhosted.org/packages/85/c5/7a4f68164671e8877c381b19481b8aa478374c22627ff5609c1d2b4534fb
PYTHON_PUTDIG_SETUP_TYPE = setuptools
PYTHON_PUTDIG_LICENSE = MIT

$(eval $(python-package))
