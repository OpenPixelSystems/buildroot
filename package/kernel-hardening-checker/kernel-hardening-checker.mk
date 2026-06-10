################################################################################
#
# kernel-hardening-checker
#
################################################################################

KERNEL_HARDENING_CHECKER_VERSION = 0.6.17.1
KERNEL_HARDENING_CHECKER_SITE = $(call github,a13xp0p0v,kernel-hardening-checker,v$(KERNEL_HARDENING_CHECKER_VERSION))
KERNEL_HARDENING_CHECKER_LICENSE = GPL-3.0
KERNEL_HARDENING_CHECKER_LICENSE_FILES = LICENSE.txt
KERNEL_HARDENING_CHECKER_SETUP_TYPE = setuptools

$(eval $(host-python-package))
