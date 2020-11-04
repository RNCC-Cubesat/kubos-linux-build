################################################################################
#
# python-pumpkin-supmcu
#
################################################################################

PYTHON_PUMPKIN_SUPMCU_VERSION = 1.2.0
PYTHON_PUMPKIN_SUPMCU_SOURCE = pumpkin_supmcu-$(PYTHON_PUMPKIN_SUPMCU_VERSION).tar.gz
PYTHON_PUMPKIN_SUPMCU_SITE = https://files.pythonhosted.org/packages/76/07/7ffc0af4479674610ba789368b3edde753b732ad9d2232e91d1ee74e0077
PYTHON_PUMPKIN_SUPMCU_SETUP_TYPE = setuptools
PYTHON_PUMPKIN_SUPMCU_LICENSE = MIT

$(eval $(python-package))
