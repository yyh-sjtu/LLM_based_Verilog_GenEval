
module TopModule (
    input  wire   clk,
    input  wire [7:0] d,
    output wire [7:0] q
);

    reg [7:0] q_reg;
    reg [7:0] d_reg;

    always @(posedge clk) begin
        q_reg <= d_reg;
    end

    always @(posedge clk) begin
        d_reg <= d;
    end

    assign q = q_reg;

endmodule