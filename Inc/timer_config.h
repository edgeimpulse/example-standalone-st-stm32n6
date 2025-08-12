
#ifndef _TIMER_CONFIG_H
#define _TIMER_CONFIG_H

#include "stm32n6xx_hal.h"

#ifdef __cplusplus
extern "C" {
#endif

extern HAL_StatusTypeDef timer_config_init(void);
extern uint64_t timer_config_read_ns(void);

#ifdef __cplusplus
}
#endif

#endif /* _TIMER_CONFIG_H */