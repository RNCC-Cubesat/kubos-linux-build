################################################################################
#
# python-pumpkin-supmcu
#
################################################################################

PYTHON_PUMPKIN_SUPMCU_VERSION = 1.1.0
PYTHON_PUMPKIN_SUPMCU_SOURCE = pumpkin_supmcu-$(PYTHON_PUMPKIN_SUPMCU_VERSION).tar.gz
PYTHON_PUMPKIN_SUPMCU_SITE = https://files.pythonhosted.org/packages/c2/88/5da2b6bb4a9c538e179cc2d7c8acf1d504e69e9706a1424c771290ee7452
PYTHON_PUMPKIN_SUPMCU_SETUP_TYPE = setuptools
PYTHON_PUMPKIN_SUPMCU_LICENSE = MIT

$(eval $(python-package))
