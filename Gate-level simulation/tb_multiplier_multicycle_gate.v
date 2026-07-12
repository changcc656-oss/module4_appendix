`timescale 1ns/1ps

module tb_multiplier_mc_gate;

    reg         clk;
    reg         reset;
    reg         start;
    reg  [31:0] a;
    reg  [31:0] b;
    wire [63:0] result;
    wire        valid;
    wire        busy;

    multiplier_mc dut (
        .clk    (clk),
        .reset  (reset),
        .start  (start),
        .a      (a),
        .b      (b),
        .result (result),
        .valid  (valid),
        .busy   (busy)
    );

    initial begin
        clk = 1'b0;
        forever #0.5 clk = ~clk;   // 1 ns clock period
    end

    initial begin
        $vcdplusfile("multiplier_mc_gate.vpd");
        $vcdpluson(0, tb_multiplier_mc_gate);
    end

    initial begin
        if ($test$plusargs("sdf")) begin
            $sdf_annotate("mul32_mc.sdf", dut);
        end
    end

    task run_test;
        input [31:0] test_a;
        input [31:0] test_b;
        reg   [63:0] expected;
        integer elapsed_cycle;
        integer timeout;
        begin
            expected = test_a * test_b;
            elapsed_cycle = 0;
            timeout = 0;

            @(posedge clk);
            #0.1;
            a     = test_a;
            b     = test_b;
            start = 1'b1;

            // This posedge captures start, a, and b into the DUT.
            @(posedge clk);
            #0.1;
            start = 1'b0;

            while ((valid !== 1'b1) && (timeout < 20)) begin
                @(posedge clk);
                elapsed_cycle = elapsed_cycle + 1;

                // Sample after clock-to-Q delay has settled.
                @(negedge clk);
                timeout = timeout + 1;
            end

            if (valid !== 1'b1) begin
                $display("FAIL: timeout waiting for valid, a=%0d b=%0d", test_a, test_b);
            end else if (elapsed_cycle !== 6) begin
                $display("FAIL: expected 6 cycles, got %0d cycles, a=%0d b=%0d",
                         elapsed_cycle, test_a, test_b);
            end else if (result !== expected) begin
                $display("FAIL: a=%0d b=%0d result=%0d expected=%0d cycles=%0d",
                         test_a, test_b, result, expected, elapsed_cycle);
            end else begin
                $display("PASS: a=%0d b=%0d result=%0d cycles=%0d",
                         test_a, test_b, result, elapsed_cycle);
            end

            @(posedge clk);
            #0.1;
            a = 32'd0;
            b = 32'd0;
        end
    endtask

    initial begin
        reset = 1'b1;
        start = 1'b0;
        a     = 32'd0;
        b     = 32'd0;

        repeat (3) @(posedge clk);
        #0.3;
        reset = 1'b0;

        repeat (2) @(posedge clk);

        run_test(32'd3,          32'd5);
        run_test(32'd10,         32'd20);
        run_test(32'd12345,      32'd6789);
        run_test(32'h0000_FFFF,  32'h0000_0002);
        run_test(32'hFFFF_FFFF,  32'd2);
        run_test(32'hFFFF_FFFF,  32'hFFFF_FFFF);

        repeat (5) @(posedge clk);

        $display("Gate-level multicycle simulation finished.");
        $vcdplusoff;
        $finish;
    end

endmodule
