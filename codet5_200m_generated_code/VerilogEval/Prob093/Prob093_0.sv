module TopModule (
	input c,
	input d,
	output [3:0] mux_in
);
    localparam A1 = 5'b00000;
    localparam A2 = 5'b000000;
    localparam A3 = 5'b00000;
    localparam A4 = 5'b000000;
    localparam B1 = 5'b00000;
    localparam B2 = 5'b00000;
    localparam B3 = 5'b00000;
    localparam B4 = 5'b00000;
    reg [3:0] mux_out;
    always @(*) begin
        case (c)
            3'b000: mux_out = 4'b0000; 
            3'b001: mux_out = 4'b0001; 
            3'b010: mux_out = 4'b0010; 
            3'b011: mux_out = 4'b0100; 
            3'b100: mux_out = 4'b0011; 
            3'b101: mux_out = 4'b0100; 
            3'b110: mux_out = 4'b0101; 
            3'b111: mux_out = 4'b1001; 
        endcase
    end
    always @(*) begin
        case (d)
            3'b000: mux_out = 4'b0010; 
            3'b001: mux_out = 4'b0100; 
            3'b010: mux_out = 4'b0101; 
            3'b011: mux_out = 4'b1000; 
            3'b012: mux_out = 4'b1001; 
            3'b100: mux_out = 4'b1010; 
            3'b101: mux_out = 4'b1011; 
            3'b110: mux_out = 4'b1011; 
            3'b111: mux_out = 4'b1100; 
        endcase
    end
    always @(*) begin
        case (d)
            3'b001: mux_out = 4'b0010; 
            3'b010: mux_out = 4'b0111; 
            3'b011: mux_out = 4'b1000; 
            3'b100: mux_out = 4'b1101; 
            3'b101: mux_out = 4'b1110; 
            3'b110: mux_out = 4'b1101; 
            3'b111: mux_out = 4'b1110; 
        endcase
    end
    always @(*) begin
        case (c)
            3'b000: mux_out = 4'b0001; 
            3'b001: mux_out = 4'b0001; 
            3'b010: mux_out = 4'b0100; 
            3'b100: mux_out = 4'b1000; 
            3'b110: mux_out = 4'b1101; 
            3'b111: mux_out = 4'b1110; 
        endcase
    end
    always @(*) begin
        case (d)
            3'b001: mux_out = 4'b0011; 
            3'b101: mux_out = 4'b1010; 
            3'b101: mux_out = 4'b1101; 
            3'b111: mux_out = 4'b1110; 
        endcase
    end
endmodule

