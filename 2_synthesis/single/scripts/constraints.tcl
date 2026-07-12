# Clock constraint: 1 ns period
create_clock -name clk -period 1.0 [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]

# Input delay for non-clock, non-reset inputs
set_input_delay 0.1 -clock [get_clocks clk] [get_ports {start a b}]

# Output delay
set_output_delay 0.1 -clock [get_clocks clk] [get_ports {valid result}]

# Input transition
set_input_transition 0.05 [get_ports {start a b}]

# Output load
set_load 0.001 [get_ports {valid result}]

set_false_path -from [get_ports reset]
