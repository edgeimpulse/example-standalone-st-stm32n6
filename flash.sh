#!/bin/bash
set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin:$PATH"
EL="$(dirname "$(which STM32_Programmer_CLI)")/ExternalLoader/MX66UW1G45G_STM32N6570-DK.stldr"

TARGET=$1

if [ -z "$TARGET" ]; then
    TARGET="all"
fi

echo ${EL}

GCC_PATH=~/work/toolchain/arm-gnu-toolchain-13.3.rel1-darwin-arm64-arm-none-eabi/bin
arm-none-eabi-objcopy -O ihex build/Project.elf build/Project.hex
arm-none-eabi-objcopy -O binary build/Project.elf build/Project.bin

# sign bin
STM32_SigningTool_CLI -s -bin build/Project.bin -nk -t fsbl -hv 2.1 -o build/project-trusted.bin

echo "Flashing ${TARGET}"
if [ "$TARGET" == "firmware" ]; then
    STM32_Programmer_CLI -c port=SWD mode=HOTPLUG ap=1 -el ${EL} -hardRst -w build/project-trusted.bin 0x70080000
elif [ "$TARGET" == "all" ]; then
    STM32_Programmer_CLI -c port=SWD mode=HOTPLUG ap=1 -el ${EL} -hardRst -w Model/network_data.hex
    STM32_Programmer_CLI -c port=SWD mode=HOTPLUG ap=1 -el ${EL} -hardRst -w build/project-trusted.bin 0x70080000
elif [ "$TARGET" == "weights" ]; then
    STM32_Programmer_CLI -c port=SWD mode=HOTPLUG ap=1 -el ${EL} -hardRst -w Model/network_data.hex
elif [ "$TARGET" == "bootloader" ]; then
    STM32_Programmer_CLI -c port=SWD mode=HOTPLUG ap=1 -el ${EL} -hardRst -w ai_fsbl_cut_2_0.hex
else
    echo "Invalid target: $TARGET"
    exit 1
fi
