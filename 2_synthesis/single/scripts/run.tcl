read_verilog ../../multiplier.v
current_design multiplier_32
link

source scripts/constraints.tcl

check_design
compile

write -f ddc -hierarchy -out netlist/mul32_single.ddc
write -f verilog -hierarchy -out netlist/mul32_single_netlist.v
write_sdf netlist/mul32_single.sdf

redirect -file reports/area.rpt { report_area }
redirect -file reports/timing.rpt { report_timing -max_paths 10 }
redirect -file reports/clock.rpt { report_clock }
redirect -file reports/cell.rpt { report_cell }
redirect -file reports/qor.rpt { report_qor }
redirect -file reports/constraint.rpt { report_constraint -all_violators }

exit
