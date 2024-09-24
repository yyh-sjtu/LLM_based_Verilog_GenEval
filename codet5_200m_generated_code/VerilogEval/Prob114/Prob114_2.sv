module TopModule (
	input [7:0] code,
	output [3:0] out,
	output valid
);
    always @ (code[7:0])
    begin
        case (code)
            8'b000001: out = 4'b1110;
            8'b111110: out = 4'b1111;
            8'b000001: out = 4'b1101;
            8'b000010: out = 4'b1110;
            8'b000100: out = 4'b0100;
            8'b000101: out = 4'b0001;
            8'b001001: out = 4'b00100;
            8'b001010: out = 4'b00101;
            8'b001100: out = 4'b0011;
            8'b001101: out = 4'b0011;
            8'b001110: out = 4'b0011;
            8'b001101: out = 4'b0011;
            8'b001001: out = 4'b00100;
            8'b001110: out = 4'b0011;
            8'b01000: out = 4'b01000;
            8'b01001: out = 4'b01000;
            8'b01010: out = 4'b01010;
            8'b01011: out = 4'b0101;
            8'b01100: out = 4'b01100;
            8'b01101: out = 4'b01101;
            8'b01110: out = 4'b01110;
            8'b01111: out = 4'b01111;
            default: out = 4'b1111;
        endcase
    end
    assign valid =!out[0];
endmodule

