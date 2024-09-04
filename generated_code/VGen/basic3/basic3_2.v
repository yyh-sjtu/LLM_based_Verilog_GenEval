
module priority_encoder(
    input [2:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in)
        3'b1??: pos = 2'b10;  // If input 2 is high
        3'b01?: pos = 2'b01;  // If input 1 is high
        3'b00?: pos = 2'b00;  // If all inputs are low
        default: pos = 2'b00;  // Default case
    endcase
end

endmodule