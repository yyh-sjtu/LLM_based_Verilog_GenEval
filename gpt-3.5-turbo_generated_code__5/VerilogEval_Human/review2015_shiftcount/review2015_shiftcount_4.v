module shift_register_counter (
    input wire clk,
    input wire shift_ena,
    input wire count_ena,
    input wire data,
    output reg [3:0] q
);

reg [3:0] shift_reg;

always @(posedge clk) begin
    if (shift_ena == 1) begin
        shift_reg <= {shift_reg[2:0], data};
    end
    else if (count_ena == 1) begin
        shift_reg <= shift_reg - 1;
    end
end

assign q = shift_reg;

endmodule

module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);
    
shift_register_counter counter (
    .clk(clk),
    .shift_ena(shift_ena),
    .count_ena(count_ena),
    .data(data),
    .q(q)
);

endmodule

