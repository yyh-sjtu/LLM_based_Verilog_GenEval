
module TopModule(
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
        if (ena == 2'b01) begin // Rotate right
            shift_reg <= {shift_reg[0], shift_reg[99:1]};
        end else if (ena == 2'b10) begin // Rotate left
            shift_reg <= {shift_reg[98:0], shift_reg[99]};
        end
    end
end

assign q = shift_reg;

endmodule