 /**
 ******************************************************************************
 * @file    main.c
 * @author  GPM Application Team
 *
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2023 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */

#include <assert.h>

#include "app_config.h"
#include "system_clock_config.h"
#include "mcu_cache.h"
#include "app_fuseprogramming.h"
#include "main.h"
#if (NUCLEO_N6_CONFIG == 0)
#include "stm32n6570_discovery.h"
#else
#include "stm32n6xx_nucleo.h"
#endif
#include <stdio.h>
#include "misc_toolbox.h"
#include "npu_cache.h"
#if defined(USE_NS_TIMER) && (USE_NS_TIMER == 1)
#include "timer_config.h"
#endif

static void init_external_memories(void);
extern int ei_main(void);

int main(void)
{
    set_vector_table_addr();

    HAL_Init();
    system_init_post();

    set_mcu_cache_state(USE_MCU_ICACHE, USE_MCU_DCACHE);

    /* Configure the system clock */
#if VDDCORE_OVERDRIVE == 1
    upscale_vddcore_level();
    SystemClock_Config_HSI_overdrive();
#else
    SystemClock_Config_HSI_no_overdrive();
#endif
    /* Clear SLEEPDEEP bit of Cortex System Control Register */
    CLEAR_BIT(SCB->SCR, SCB_SCR_SLEEPDEEP_Msk);

    UART_Config();

    NPU_Config();

#if defined(USE_NS_TIMER) && (USE_NS_TIMER == 1)
    timer_config_init();
#endif

    init_external_memories();

    RISAF_Config();

    set_clk_sleep_mode();

    /* start ei app */
    ei_main();

    while(1) {

    }

    return 0;
}

void IAC_IRQHandler(void)
{
  while (1)
  {
  }
}

#ifdef  USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{
  UNUSED(file);
  UNUSED(line);
  __BKPT(0);
  while (1)
  {
  }
}
#endif

/* Allow to debug with cache enable */
__attribute__ ((section (".keep_me"))) void app_clean_invalidate_dbg()
{
  SCB_CleanInvalidateDCache();
}

static void init_external_memories(void)
{
#if defined(USE_EXTERNAL_MEMORY_DEVICES) && USE_EXTERNAL_MEMORY_DEVICES == 1
  BSP_XSPI_NOR_Init_t Flash;
  
#if (NUCLEO_N6_CONFIG == 0)
  BSP_XSPI_RAM_Init(0);
  BSP_XSPI_RAM_EnableMemoryMappedMode(0);
  /* Configure the memory in octal DTR */
  Flash.InterfaceMode = MX66UW1G45G_OPI_MODE;
  Flash.TransferRate = MX66UW1G45G_DTR_TRANSFER;
#else
  Flash.InterfaceMode = MX25UM51245G_OPI_MODE;
  Flash.TransferRate = MX25UM51245G_DTR_TRANSFER;
#endif
  
  if(BSP_XSPI_NOR_Init(0, &Flash) != BSP_ERROR_NONE)
  {
        __BKPT(0);
  }
  BSP_XSPI_NOR_EnableMemoryMappedMode(0);
#endif 
}
