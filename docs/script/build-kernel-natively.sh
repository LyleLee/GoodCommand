#!/bin/bash                                                                                                                                                                        
set -x

## params
version_prefix="rhel8.1-sas-5.1-update"

if [ $# -ge 1 ]; then
	version_prefix=$1
fi

COFNIG_FILE="~/config-`uname -r`"
export LOCALVERSION="-${version_prefix}-`date +%F`"
cpunum=$(getconf _NPROCESSORS_ONLN)
#cpunum=1

# targets: bindeb-pkg binrpm-pkg INSTALL_MOD_STRIP=1 Image modules INSTALL_MOD_PATH=${OUT} modules_install"
BUILD_TARGETS="rpm-pkg INSTALL_MOD_STRIP=1"

## kernel .config compile
# cp /boot/conf-xx kernel_source_dir/.config
# CONFIG: oldconfig defconfig estuary_defconfig
CONFIG="oldconfig"

make ${CONFIG}
make ${BUILD_TARGETS} -j$cpunum

set +x
