/**
  ******************************************************************************
  * @file    main.h
  * @author  MCD Application Team
  * @brief   Header for main.c module
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef _SYSTEM_CLOCK_CONFIG_H
#define _SYSTEM_CLOCK_CONFIG_H

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

void SystemClock_Config_64MHZ(void);
void SystemClock_Config_HSI_overdrive(void);
void SystemClock_Config_HSI_no_overdrive(void);
void SystemClock_Config(void);
void SystemClock_Config_Nucleo(void);

#endif /* _SYSTEM_CLOCK_CONFIG_H */
