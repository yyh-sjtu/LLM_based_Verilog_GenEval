module TopModule (
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);
    reg [3:0] code;
    assign ringer = code[0];
    assign motor = code[1];
    always @(posedge ringer or posedge vibrate_mode)
    begin
        if (vibrate_mode == 1)
            code = 3'b000;
        else
            code = 3'b001;
    end
endmodule

