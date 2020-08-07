################################################################################
#
# python-pumpkin-supmcu-kubos
#
################################################################################

PYTHON_PUMPKIN_SUPMCU_KUBOS_VERSION = 0.0.2
PYTHON_PUMPKIN_SUPMCU_KUBOS_SOURCE = pumpkin_supmcu_kubos-$(PYTHON_PUMPKIN_SUPMCU_KUBOS_VERSION).tar.gz
PYTHON_PUMPKIN_SUPMCU_KUBOS_SITE = https://files.pythonhosted.org/packages/4d/f9/ef3ba57d0e23483dd5fd0cd258acb124061bb3d50e65a3c0034cb13d3141
PYTHON_PUMPKIN_SUPMCU_KUBOS_SETUP_TYPE = setuptools
PYTHON_PUMPKIN_SUPMCU_KUBOS_LICENSE = MIT

$(eval $(python-package))
