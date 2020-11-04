################################################################################
#
# python-pumpkin-supmcu-kubos
#
################################################################################

PYTHON_PUMPKIN_SUPMCU_KUBOS_VERSION = 0.0.3
PYTHON_PUMPKIN_SUPMCU_KUBOS_SOURCE = pumpkin_supmcu_kubos-$(PYTHON_PUMPKIN_SUPMCU_KUBOS_VERSION).tar.gz
PYTHON_PUMPKIN_SUPMCU_KUBOS_SITE = https://files.pythonhosted.org/packages/ad/e9/483d63a73fb8d27760d9f04beaa3c9f01c47200e5a5af01df58d23e12da5
PYTHON_PUMPKIN_SUPMCU_KUBOS_SETUP_TYPE = setuptools
PYTHON_PUMPKIN_SUPMCU_KUBOS_LICENSE = MIT

$(eval $(python-package))
