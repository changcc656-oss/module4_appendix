# Clock constraint
create_clock -name clk -period 1.0 [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]

# Input/output timing constraints
set_input_delay 0.1 -clock [get_clocks clk] [get_ports {start a b}]
set_output_delay 0.1 -clock [get_clocks clk] [get_ports {valid result}]

set_input_transition 0.05 [get_ports {start a b}]
set_load 0.001 [get_ports {valid result}]

# Reset is asynchronous
set_false_path -from [get_ports reset]

set MC_CYCLES 6

set launch_regs  [get_cells {a_reg_reg[*] b_reg_reg[*]}]
set capture_regs [get_cells {result_reg[*]}]

set_multicycle_path -setup $MC_CYCLES -from $launch_regs -to   $capture_regs

set_multicycle_path -hold [expr $MC_CYCLES - 1] -from $launch_regs -to   $capture_regs
