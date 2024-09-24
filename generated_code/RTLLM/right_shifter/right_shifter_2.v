
module right_shifter (
    input clk,
    input d,
    output reg [7:0] q
);

initial begin
    q = 8'b0;
end

always @(posedge clk) begin
    q <= {1'b0, q[7:1]}; // right shift by 1 bit
    q[7] <= d; // insert new input bit into MSB position
end

endmodule