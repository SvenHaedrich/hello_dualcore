# Copyright (c) 2024 Nordic Semiconductor ASA
# SPDX-License-Identifier: Apache-2.0

if("${SB_CONFIG_RISCV_CPU}" STREQUAL "")
  message(FATAL_ERROR "RISCV_CPU must be set to a valid board name")
endif()

ExternalZephyrProject_Add(
  APPLICATION riscv
  SOURCE_DIR ${APP_DIR}/riscv
  BOARD ${SB_CONFIG_RISCV_CPU}
)

add_dependencies(hello_dualcore riscv)
sysbuild_add_dependencies(FLASH hello_dualcore riscv)
