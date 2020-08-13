################################################################################
#
# python-pumpkin-supmcu
#
################################################################################

PYTHON_PUMPKIN_SUPMCU_VERSION = 1.1.1
PYTHON_PUMPKIN_SUPMCU_SOURCE = pumpkin_supmcu-$(PYTHON_PUMPKIN_SUPMCU_VERSION).tar.gz
PYTHON_PUMPKIN_SUPMCU_SITE = https://files.pythonhosted.org/packages/82/93/48df994f3694ddde6257cae637cde21cc8a1ac5273dcae26ed90b0dc593f
PYTHON_PUMPKIN_SUPMCU_SETUP_TYPE = setuptools
PYTHON_PUMPKIN_SUPMCU_LICENSE = MIT

$(eval $(python-package))
