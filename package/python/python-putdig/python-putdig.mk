################################################################################
#
# python-putdig
#
################################################################################

PYTHON_PUTDIG_VERSION = 0.0.2
PYTHON_PUTDIG_SOURCE = PuTDIG-$(PYTHON_PUTDIG_VERSION).tar.gz
PYTHON_PUTDIG_SITE = https://files.pythonhosted.org/packages/83/13/8f5103e8811e96286c8672914978125a77cd3813982b50841e1cdfb9dfab
PYTHON_PUTDIG_SETUP_TYPE = setuptools
PYTHON_PUTDIG_LICENSE = MIT

$(eval $(python-package))
