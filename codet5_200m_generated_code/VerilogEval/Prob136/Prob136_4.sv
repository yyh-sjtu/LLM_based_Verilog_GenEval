module TopModule (
	input clk,
	input reset,
	input w,
	output z
);
    reg [3:0] state = 2'b00;
    reg [3:0] c_addr = 2'b10;
    reg [3:0] d_addr = 2'b11;
    wire [3:0] z;
    assign z = z;
    always @(posedge clk) begin
        case(state)
            2'b00: begin
                if(w)
                    state <= 2'b01;
                else
                    state <= 2'b10;
            end
            2'b01: begin
                if(w)
                    state <= 2'b10;
                else
                    state <= 2'b11;
            end
            2'b10: begin
                if(w)
                    state <= 2'b11;
                else
                    state <= 2'b00;
            end
            2'b11: begin
                if(w)
                    state <= 2'b00;
                else
                    state <= 2'b00;
            end
        endcase
    end
endmodule

