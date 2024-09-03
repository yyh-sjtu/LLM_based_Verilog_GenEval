module for the 16-bit full adder
module full_adder_16bit(
    input [15:0] A,
    input [15:0] B,
    input cin,
    output reg [15:0] sum,
    output reg cout
);

// Create 16 full adder cells
genvar i;
generate
    for(i = 0; i < 16; i = i + 1) begin : full_adder_cell
        full_adder full_adder_inst(
            .A(A[i]),
            .B(B[i]),
            .cin(cin),
            .sum(sum[i]),
            .cout(cout)
        );
    end
endgenerate

endmodule

module for the full adder
module full_adder(
    input A,
    input B,
    input cin,
    output reg sum,
    output reg cout
);

// Implement the full adder logic
always @(*) begin
    sum = A ^ B ^ cin;
    cout = (A & B) | (A & cin) | (B & cin);
end

endmodule

module for the decade counter
module decade_counter(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

// Instantiate the 16-bit full adder module
full_adder_16bit full_adder_inst(
    .A(q),
    .B(16'b1), // Increment value of 1 as input B
    .cin(slowena),
    .sum(q),
    .cout()
);

// Reset logic
always @(*) begin
    if(reset) begin
        q <= 4'b0; // Reset the counter to 0
    end
end

endmodule

module to test the decade counter
module top(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

// Instantiate the decade counter module
decade_counter decade_counter_inst(
    .clk(clk),
    .slowena(slowena),
    .reset(reset),
    .q(q)
);

endmodule

