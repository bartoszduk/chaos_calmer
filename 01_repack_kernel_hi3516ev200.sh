#!/bin/bash

IMG="./build_dir/target-arm_cortex-a7_uClibc-0.9.33.2_eabi/linux-hi35xx_16ev200/linux-4.9.37/arch/arm/boot/zImage"
DTB="./build_dir/target-arm_cortex-a7_uClibc-0.9.33.2_eabi/linux-hi35xx_16ev200/linux-4.9.37/arch/arm/boot/dts/hi3516ev200.dtb"

clear

cat ${IMG} ${DTB} > ./zImage-dtb

./staging_dir/host/bin/mkimage \
  -A arm -O linux -T kernel -C none -a 0x40008000 -e 0x40008000 -n "OpenIPC $(date '+%Y.%m.%d %H:%M:%S')" \
  -d ./zImage-dtb ./uImage

echo
scp ./uImage zig@172.28.200.74:/sync/Archive/Incoming/Tftp && rm -f zImage-dtb uImage
