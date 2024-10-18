module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state;

always @(posedge clk or negedge resetn)
begin
    if (!resetn)
        state <= 2'b00;
    else
        case (state)
            2'b00: begin
                     if (resetn)
                         state <= 2'b01;
                    end
            2'b01: begin
                     state <= 2'b10;
                     f <= 1'b1;
                    end
            2'b10: begin
                     if (x == 1 && #(1) x == 0 && #(1) x == 1)
                         state <= 2'b11;
                    end
            2'b11: begin
                     if (y == 1)
                         state <= 2'b11;
                     else if (y == 0 && #(2) y == 0)
                         state <= 2'b00;
                    end
        endcase
end

assign g = (state == 2'b11);

endmodule

