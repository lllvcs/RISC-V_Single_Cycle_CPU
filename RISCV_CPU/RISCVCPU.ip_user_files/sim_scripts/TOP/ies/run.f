-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_CPU_0_0/sim/TOP_CPU_0_0.v" \
  "../../../bd/TOP/ip/TOP_mem_control_0_0/sim/TOP_mem_control_0_0.v" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_blk_mem_gen_1_0/sim/TOP_blk_mem_gen_1_0.v" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_3_6 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/2751/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib ies_lib/axi_bram_ctrl_v4_0_13 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/20fd/hdl/axi_bram_ctrl_v4_0_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_axi_bram_ctrl_0_0/sim/TOP_axi_bram_ctrl_0_0.vhd" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/02c8/hdl/sc_util_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/axi_protocol_checker_v2_0_1 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/3b24/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/axi_vip_v1_1_1 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/a16a/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_3 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/1313/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_processing_system7_0_0/sim/TOP_processing_system7_0_0.v" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_12 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_rst_ps7_0_50M_0/sim/TOP_rst_ps7_0_50M_0.vhd" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/786b/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_5/sim/bd_ab6f_s00a2s_0.sv" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/92d2/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_11/sim/bd_ab6f_m00s2a_0.sv" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/258c/hdl/sc_exit_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_12/sim/bd_ab6f_m00e_0.sv" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/e2dd/hdl/sc_node_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_6/sim/bd_ab6f_sarn_0.sv" \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_7/sim/bd_ab6f_srn_0.sv" \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_8/sim/bd_ab6f_sawn_0.sv" \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_9/sim/bd_ab6f_swn_0.sv" \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_10/sim/bd_ab6f_sbn_0.sv" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/8ad6/hdl/sc_mmu_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_2/sim/bd_ab6f_s00mmu_0.sv" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/0f5f/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_3/sim/bd_ab6f_s00tr_0.sv" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/925a/hdl/sc_si_converter_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_4/sim/bd_ab6f_s00sic_0.sv" \
-endlib
-makelib ies_lib/xlconstant_v1_1_3 \
  "../../../../RISCVCPU.srcs/sources_1/bd/TOP/ipshared/0750/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_0/sim/bd_ab6f_one_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/ip/ip_1/sim/bd_ab6f_psr_aclk_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/TOP/ip/TOP_axi_smc_0/bd_0/sim/bd_ab6f.v" \
  "../../../bd/TOP/ip/TOP_axi_smc_0/sim/TOP_axi_smc_0.v" \
  "../../../bd/TOP/ip/TOP_blk_mem_gen_0_1/sim/TOP_blk_mem_gen_0_1.v" \
  "../../../bd/TOP/sim/TOP.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

