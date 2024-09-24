
module left_rotate (
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

reg [7:0] shift_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= 8'h00;
    end else begin
        if (load) begin
            shift_reg <= data;
        end else begin
            shift_reg <= {shift_reg[(7-amount):0], shift_reg[7:(8-amount)]};
        end
    end
end

assign out = shift_reg;

endmodule