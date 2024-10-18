module right_shifter (
    input wire clk,
    input wire d,
    output reg [7:0] q
);

initial begin
    q = 8'b0; // Initializing q register to 0
end

always @(posedge clk) begin
    q <= {d, q[7:1]}; // Right shift q by 1 bit and insert new input bit d into most significant position
end

endmodule

