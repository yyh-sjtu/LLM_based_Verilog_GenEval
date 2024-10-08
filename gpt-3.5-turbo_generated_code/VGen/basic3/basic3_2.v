
module priority_encoder( 
    input [2:0] in,
    output reg [1:0] pos 
);

always @(*) begin
    case (in)
        3'b000: pos = 2'b00;
        3'b001: pos = 2'b00;
        3'b010: pos = 2'b01;
        3'b011: pos = 2'b00;
        3'b100: pos = 2'b10;
        3'b101: pos = 2'b00;
        3'b110: pos = 2'b01;
        3'b111: pos = 2'b00;
    endcase
end

endmodule