
module TopModule (
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

reg [99:0] shift_reg;

always @(posedge clk) begin
    if (load) begin
        shift_reg <= data;
    end else begin
        case (ena)
            2'b01: shift_reg <= {shift_reg[0], shift_reg[99:1]};
            2'b10: shift_reg <= {shift_reg[1:99], shift_reg[0]};
            default: shift_reg <= shift_reg;
        endcase
    end
end

assign q = shift_reg;

endmodule