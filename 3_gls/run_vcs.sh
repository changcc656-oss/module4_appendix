vcs -full64 -sverilog -timescale=1ns/1ps -debug_access+all \
    /pdk/SAED32_EDK/lib/stdcell_rvt/verilog/saed32nm.v \
    mul32_mc_netlist.v \
    tb_multiplier_mc_gate.v \
    -o simv_mc_gate \
    -l compile_mc_gate.log

./simv_mc_gate +sdf-l sim_mc_gate.log
