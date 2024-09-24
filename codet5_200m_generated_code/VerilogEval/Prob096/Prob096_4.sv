module TopModule (
	input clk,
	input reset,
	input data,
	output start_shifting
);
    reg [7:0] code;
    reg [7:0] next_state;
    always @ (posedge clk or posedge reset) begin
        if(reset == 1'b1) begin
            code <= 8'b0;
        end
        else if(next_state == 7'h1) begin
            if(code == 8'h02) begin
                next_state <= 7'h2;
                start_shifting <= 1'b1;
            end
            else begin
                next_state <= next_state + 1;
                start_shifting <= 1'b0;
            end
        end
    end
endmodule

