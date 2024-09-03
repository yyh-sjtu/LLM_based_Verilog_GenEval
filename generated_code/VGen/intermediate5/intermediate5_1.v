
module full_adder_16bit(
    input [15:0] A,
    input [15:0] B,
    input cin,
    output [15:0] sum,
    output cout
);

wire [15:0] carry_out;
wire [15:0] carry_out_next;

genvar i;
generate
    for(i = 0; i < 16; i = i + 1) begin : adder_loop
        full_adder FA(
            .A(A[i]),
            .B(B[i]),
            .cin(carry_out[i]),
            .sum(sum[i]),
            .cout(carry_out_next[i])
        );
    end
endgenerate

assign carry_out[0] = cin; // Initial carry in
assign cout = carry_out[15]; // Carry out of the MSB

endmodule

module left_rotate(
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

reg [15:0] shifted_data;
reg [15:0] rotated_data;

assign shifted_data = {8'd0, data};
full_adder_16bit FA16(
    .A(shifted_data),
    .B(shifted_data << amount,
    .cin(1'b0),
    .sum(rotated_data),
    .cout
);

always @(posedge clk or posedge reset) begin
    if(reset)
        out <= 8'b0;
    else if(load)
        out <= data;
    else
        out <= rotated_data[7:0];
end

endmodule