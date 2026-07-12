module multiplier_32 (
    input  clk,
    input  reset,
    input  start,
    input  [31:0] a,
    input  [31:0] b,
    output reg  [63:0] result,
    output reg  valid
);

    reg [31:0] a_reg;
    reg [31:0] b_reg;
    reg        start_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_reg     <= 32'd0;
            b_reg     <= 32'd0;
            start_reg <= 1'b0;
            result    <= 64'd0;
            valid     <= 1'b0;
        end else begin
            a_reg     <= a;
            b_reg     <= b;
            start_reg <= start;

            result    <= a_reg * b_reg;
            valid     <= start_reg;
        end
    end

endmodule
