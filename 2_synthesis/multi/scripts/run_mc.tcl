read_verilog ../../multiplier_mc.v
current_design multiplier_mc
link

source scripts/constraints_mc.tcl

check_design
compile

write -f ddc -hierarchy -out netlist/mul32_mc.ddc
write -f verilog -hierarchy -out netlist/mul32_mc_netlist.v
write_sdf netlist/mul32_mc.sdf

redirect -file reports/area.rpt { report_area }
redirect -file reports/timing.rpt { report_timing -max_paths 10 }
redirect -file reports/clock.rpt { report_clock }
redirect -file reports/cell.rpt { report_cell }
redirect -file reports/qor.rpt { report_qor }
redirect -file reports/constraint.rpt { report_constraint -all_violators }

exit
