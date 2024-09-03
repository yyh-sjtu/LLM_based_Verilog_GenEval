module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output reg sum,
    output reg cout
);

always @(*)
begin
    sum = a ^ b ^ cin;
    cout = (a & b) | (cin & (a ^ b));
end

endmodule

module advshift (
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

always @(posedge clk)
begin
    if(load)
        q <= data;
    else if (ena)
    begin
        case(amount)
            2'b00: q <= {q[62:0],1'b0};
            2'b01: q <= {q[55:0],8'b00000000};
            2'b10: q <= {1'b0,q[63:1]};
            2'b11: q <= {8'b00000000,q[63:8]};
        endcase
    end
end

endmodule

