vcs -full64 -sverilog -timescale=1ns/1ps -debug_access+all ../../multiplier.v ../../tb_multiplier.v -o simv -l compile.log
./simv -l sim.log
