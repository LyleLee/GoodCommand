#!/bin/bash                                                                                                                                                                        
COFNIG_FILE=~/config-4.16.0-estuary.5.aarch64
export LOCALVERSION="-liuxl-test-`date +%F`"
cpunum=$(getconf _NPROCESSORS_ONLN)

# targets: bindeb-pkg binrpm-pkg INSTALL_MOD_STRIP=1 Image modules INSTALL_MOD_PATH=${OUT} modules_install"
BUILD_TARGETS="binrpm-pkg INSTALL_MOD_STRIP=1" 

set -x

## kernel .config compile
#cp ${COFNIG_FILE} ${OUT}/.config	
# CONFIG: oldconfig defconfig estuary_defconfig
CONFIG="oldconfig"

make ${CONFIG}
make ${BUILD_TARGETS} -j$cpunum

set +x
