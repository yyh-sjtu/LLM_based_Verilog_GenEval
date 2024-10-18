
module TopModule (
    input  wire         clk,
    input  wire         reset,
    input  wire  [31:0] in,
    output wire  [31:0] out
);
    reg [31:0] out_reg;
    reg [31:0] in_reg;
    
    always @(posedge clk) begin
        if (reset)
            out_reg <= 0;
        else if (in_reg == 32'b11111111111111111111111111111110 && in == 1'b0)
            out_reg <= 32'b11111111111111111111111111111111;
        else
            out_reg <= out_reg;
        
        in_reg <= in;
    end
    
    assign out = out_reg;
endmodule