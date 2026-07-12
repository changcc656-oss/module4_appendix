module tb_multiplier;

    reg         clk;
    reg         reset;
    reg         start;
    reg  [31:0] a;
    reg  [31:0] b;
    wire [63:0] result;
    wire        valid;

    multiplier_32 dut (
        .clk    (clk),
        .reset  (reset),
        .start  (start),
        .a      (a),
        .b      (b),
        .result (result),
        .valid  (valid)
    );

    initial begin
        clk = 1'b0;
        forever #0.5 clk = ~clk;
    end

    initial begin
        $vcdplusfile("multiplier.vpd");
        $vcdpluson(0, tb_multiplier);
    end

    task run_test;
        input [31:0] test_a;
        input [31:0] test_b;
        reg   [63:0] expected;
        begin
            expected = test_a * test_b;

           @(posedge clk);
		#0.1;
        	a     = test_a;
        	b     = test_b;
        	start = 1'b1;

       	   @(posedge clk);
 		#0.1;
        	start = 1'b0;
        	a     = 32'd0;
        	b     = 32'd0;

           @(posedge clk);
		#0.1;

            if (valid !== 1'b1) begin
                $display("FAIL: valid not asserted for a=%0d b=%0d", test_a, test_b);
            end else if (result !== expected) begin
                $display("FAIL: a=%0d b=%0d result=%0d expected=%0d",
                         test_a, test_b, result, expected);
            end else begin
                $display("PASS: a=%0d b=%0d result=%0d", test_a, test_b, result);
            end

           @(posedge clk);
		#0.1;
        end
    endtask

    initial begin
        reset = 1'b1;
        start = 1'b0;
        a = 32'd0;
        b = 32'd0;

        repeat (2) @(posedge clk);
        reset = 1'b0;

        run_test(32'd3,          32'd5);
        run_test(32'd10,         32'd20);
        run_test(32'd12345,      32'd6789);
        run_test(32'h0000_FFFF,  32'h0000_0002);
        run_test(32'hFFFF_FFFF,  32'd2);
        run_test(32'hFFFF_FFFF,  32'hFFFF_FFFF);

        repeat (5) @(posedge clk);

        $display("Simulation finished.");
        $vcdplusoff;
        $finish;
    end

endmodule
