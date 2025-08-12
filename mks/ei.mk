# Cpp sources
CXX_SOURCES += edgeimpulse/ei_main.cpp
CXX_SOURCES += edgeimpulse/edge-impulse-sdk/porting/stm32-cubeai/ei_classifier_porting.cpp
CXX_SOURCES += $(wildcard edgeimpulse/tflite-model/*.cpp) \
	$(wildcard edgeimpulse/edge-impulse-sdk/dsp/dct/*.cpp) \
	$(wildcard edgeimpulse/edge-impulse-sdk/dsp/kissfft/*.cpp) \
	$(wildcard edgeimpulse/edge-impulse-sdk/dsp/image/*.cpp )

CC_SOURCES = $(wildcard edgeimpulse/edge-impulse-sdk/tensorflow/lite/kernels/*.cc) \
	$(wildcard edgeimpulse/edge-impulse-sdk/tensorflow/lite/kernels/internal/*.cc) \
	$(wildcard edgeimpulse/edge-impulse-sdk/tensorflow/lite/micro/*.cc) \
	$(wildcard edgeimpulse/edge-impulse-sdk/tensorflow/lite/micro/kernels/*.cc) \
	$(wildcard edgeimpulse/edge-impulse-sdk/tensorflow/lite/micro/memory_planner/*.cc) \
	$(wildcard edgeimpulse/edge-impulse-sdk/tensorflow/lite/core/api/*.cc) \

CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk/classifier
CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk/classifier/inference_engines
CXX_INCLUDES += -Iedgeimpulse
CXX_INCLUDES += -IInc
CXX_INCLUDES += -ILib
CXX_INCLUDES += -ILib/AI_Runtime/Inc
CXX_INCLUDES += -ILib/AI_Runtime/Npu/ll_aton
CXX_INCLUDES += -ILib/AI_Runtime/Npu/Devices/STM32N6XX
CXX_INCLUDES += -ILib/Camera_Middleware
CXX_INCLUDES += -ILib/Camera_Middleware/sensors
CXX_INCLUDES += -ILib/Camera_Middleware/ISP_Library/isp/Inc
CXX_INCLUDES += -ISTM32Cube_FW_N6/Drivers/STM32N6xx_HAL_Driver/Inc
CXX_INCLUDES += -ISTM32Cube_FW_N6/Drivers/CMSIS/Device/ST/STM32N6xx/Include
CXX_INCLUDES += -ISTM32Cube_FW_N6/Drivers/BSP/STM32N6570-DK
CXX_INCLUDES += -ISTM32Cube_FW_N6/Drivers/BSP/Components/Common

CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk/CMSIS/Core/Include
CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk/CMSIS/DSP/Include
CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk/CMSIS/
CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk/CMSIS/NN/Include
CXX_INCLUDES += -Iedgeimpulse
CXX_INCLUDES += -Iedgeimpulse/edge-impulse-sdk

# for ei_classifier_porting.cpp
C_DEFS += -DEI_PORTING_STM32_CUBEAI
C_DEFS += -DEI_TENSOR_ARENA_LOCATION=".tensor_arena_buf"
C_DEFS += -DEI_CLASSIFIER_ALLOCATION_STATIC
C_DEFS += -DUSE_NS_TIMER=1
