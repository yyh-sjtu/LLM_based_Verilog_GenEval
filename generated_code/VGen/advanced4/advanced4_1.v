
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
module shift_register(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] shift_data;

always @ (posedge clk) begin
    if (load) begin
        q <= data;
        shift_data <= data;
    end else begin
        case(amount)
            2'b00: shift_data <= {shift_data[62:0], 1'b0}; // shift left by 1 bit
            2'b01: shift_data <= {shift_data[55:0], 8'b0}; // shift left by 8 bits
            2'b10: shift_data <= {1'b0, shift_data[63:1]}; // shift right by 1 bit
            2'b11: shift_data <= {8'b0, shift_data[63:8]}; // shift right by 8 bits
        endcase

        if (ena)
            q <= shift_data;
    end
end

endmodule