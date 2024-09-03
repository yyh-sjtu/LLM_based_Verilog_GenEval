module full_adder (
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);

assign Sum = A ^ B ^ Cin;
assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule

module advshift(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
);

always @ (posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        case (amount)
            2'b00: q <= ena ? {q[62:0], 1'b0} : q; // shift left by 1 bit
            2'b01: q <= ena ? {q[55:0], 8'b00000000} : q; // shift left by 8 bits
            2'b10: q <= ena ? {1'b0, q[63:1]} : q; // shift right by 1 bit
            2'b11: q <= ena ? {8'b00000000, q[63:8]} : q; // shift right by 8 bits
        endcase
    end
end

endmodule

