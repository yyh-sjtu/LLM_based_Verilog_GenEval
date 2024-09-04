
module priority_encoder( 
    input [2:0] in,
    output reg [1:0] pos 
);

    always @* begin
        casez (in)
            3'b1??: pos = 2'b10;  // If the highest bit (2) is 1
            3'b01?: pos = 2'b01;  // If the second bit (1) is 1
            3'b00?: pos = 2'b00;  // If the lowest bit (0) is 1
            default: pos = 2'bxx;  // If no bits are high
        endcase
    end

endmodule