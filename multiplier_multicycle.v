module multiplier_mc (
    input  wire        clk,
    input  wire        reset,
    input  wire        start,
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [63:0] result,
    output reg         valid,
    output reg         busy
);

    reg [31:0] a_reg;
    reg [31:0] b_reg;
    reg [2:0]  count;

    wire [63:0] product_comb;

    assign product_comb = a_reg * b_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_reg  <= 32'd0;
            b_reg  <= 32'd0;
            count  <= 3'd0;
            result <= 64'd0;
            valid  <= 1'b0;
            busy   <= 1'b0;
        end else begin
            valid <= 1'b0;

            if (start && !busy) begin
                a_reg <= a;
                b_reg <= b;
                count <= 3'd0;
                busy  <= 1'b1;
            end else if (busy) begin
                count <= count + 3'd1;

                if (count == 3'd5) begin
                    result <= product_comb;
                    valid  <= 1'b1;
                    busy   <= 1'b0;
                    count  <= 3'd0;
                end
            end
        end
    end

endmodule
