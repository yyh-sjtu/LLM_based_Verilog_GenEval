module FullAdder_16bit (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire Cin,
    output reg [15:0] Sum,
    output reg Cout
);

wire [15:0] Sum1, Sum2;
reg C1, C2, C3;

assign {Cout, Sum1} = A + B;
assign {C3, Sum} = Sum1 + Cin;

always @* begin
    if (C3 || (C2 && C1)) begin
        Cout = 1'b1;
    end else begin
        Cout = 1'b0;
    end
end

endmodule
