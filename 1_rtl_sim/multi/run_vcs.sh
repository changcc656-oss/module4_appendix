vcs -full64 -sverilog -timescale=1ns/1ps -debug_access+all ../../multiplier_mc.v ../../tb_multiplier_mc.v -o simv -l compile.log
./simv -l sim.log
