# example-standalone-st-stm32n6
Example standalone for STM32N6570-DK.

Aton version is: atonn-v1.1.1-14-ge619e860

## Prerequisites

Flashing the device requires STM32 Programmer installed min version 2.18, download from https://www.st.com/en/development-tools/stm32cubeprog.html
STM32Programmer should be added to your path.

## Update your model

### Sample test
In [ei_main.cpp](edgeimpulse/ei_main.cpp) copy the raw feature you want to test:
```
static const float features[] = {
    // copy raw features here
    };
```

### Model running on NPU
Deploy your model as ST Neural-ART library.
Copy network.c and network_data.hex into the Model folder.
Copy model-paramets and edge-impulse-sdk folders into edgeimpulse.

### Model running on MCU
Deploy your model as C++ library, copy the extracted folder into the edgeimpulse folder.

NOTE: If you are testing a model running on MCU, you don't need to flash the weights.

## Build

It is strongly recommended to build using Arm Gcc 13.3, other versions may return build errors.

To build simply call:
```
make -j
```

You can build this project for the STM32N6570-DK or the NUCLEO-N657X0-Q, the default target is STM32N6570-DK.

If you want to build for the Nucleo Board use:
```
make BOARD=NUCLEO-N657X0-Q -j
```

## Flash the board

Make sure the switch BOOT1 is on the right!
Launch the script for your os, there are two arguments that can be passed.

### Flash Nucleo board
If you are testing a Nucleo board, use the --nucleo.
By default, the target is the Discovery Kit.
```
./flash.sh --nucleo
```

### What to flash
The STM32N6 is a flashless micro, for Edge AI application using NPU you need to flash:
- the firmware
- the model weights.

Also, if it is the first time you use the board, you need to flash the bootloader.

Using the --target <option >you can specify what you want to flash:
- all : flash weights and firmware
- firmware : flash the firmware
- weights : flash weights (network_data.hex) 
- bootloader : flash the fsbl (ai_fsbl_cut_2_0.hex)

For example:

```
./flash.sh --nucleo --target bootloader
```
Flash the bootloader to a Nucleo board.

```
./flash.sh --target firmware
```
Flash the firmware for the Discovery Kit.

If no argument is provided, 'all' is the default one, which flash the weights and then the firmware.

After flashing is finished, switch BOOT1 to left.
BOOT0 should be left to left postion.

NOTE: The bootloader should be flashed just once!
