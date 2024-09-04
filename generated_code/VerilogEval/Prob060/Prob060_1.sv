
module TopModule (
    input clk,
    input resetn,
    input in,
    output reg out
);

reg [3:0] shift_reg;

always @ (posedge clk or negedge resetn) begin
    if (~resetn) begin
        shift_reg <= 4'b0;
    end else begin
        shift_reg <= {in, shift_reg[3:1]};
    end
end

assign out = shift_reg[0];

endmodule