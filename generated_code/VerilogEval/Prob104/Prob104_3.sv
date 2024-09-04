
module flipflop (
    input clk, 
    input [2:0] r,
    input L,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

endmodule
module mux2to1 (
    input [2:0] sel, 
    input [2:0] in0, 
    input [2:0] in1, 
    output reg [2:0] out
);

always @* begin
    case(sel)
        0: out = in0;
        1: out = in1;
        default: out = 3'b0; // default output if sel is invalid
    endcase
end

endmodule
module TopModule (
    input clk, 
    input L,
    input q_in,
    input r_in,
    output Q
);

wire [2:0] q1, q2, q3;
flipflop ff1 (.clk(clk), .r(r_in), .L(L), .q(q1));
flipflop ff2 (.clk(clk), .r(q1), .L(L), .q(q2));
flipflop ff3 (.clk(clk), .r(q2), .L(L), .q(q3));

mux2to1 mux1 (.sel(L), .in0(q_in), .in1(q1), .out(Q));

endmodule