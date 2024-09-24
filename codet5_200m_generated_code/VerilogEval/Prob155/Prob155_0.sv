module TopModule (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);
    reg [7:0] state;
    reg [31:0] state_next;
    always @(posedge clk) begin
        state_next <= state;
    end
    always @(posedge clk) begin
        state <= state_next;
    end
    always @(posedge clk) begin
        state <= state_next;
    end
    always @(posedge clk) begin
        state_next <= state;
    end
    wire [31:0] dout;
    wire [31:0] din;
    assign dout = din[7:0];
    assign din = dout + 1;
    assign din = dout[31:16];
    assign din = dout[15:0];
    assign din = dout + 1;
    assign dout[31:0] = din[7:0];
    assign dout[15:0] = din[15:0];
    always @(posedge clk) begin
        dout[7:0] = dout;
    end
    reg [31:0] dout;
    reg [31:0] dout_reg;
    always @(posedge clk) begin
        dout_reg <= dout;
    end
    assign dout = dout_reg;
    always @(posedge clk) begin
        case (state)
            0: begin
                dout_reg <= 'b1;
                dout_reg_end = 'b1;
                dout_reg <= 'b0;
            end
            1: begin
                dout_reg <= 'b0;
                dout_reg_end = 'b0;
                dout_reg <= 'b1;
            end
            2: begin
                dout_reg <= 'b1;
                dout_reg_end = 'b1;
            end
            3: begin
                dout_reg <= 'b1;
                dout_reg_end = 'b0;
            end
            4: begin
                dout_reg <= 'b1;
                dout_reg <= 'b0;
            end
            5: begin
                dout_reg <= 'b1;
                dout_reg_end = 'b0;
            end
        6: begin
                dout_reg <= 'b1;
                dout_reg_end = 'b0;
            end
        7: begin
                dout_reg <= 'b0;
                dout_reg_end = 'b0;
            end
        8: begin
                dout_reg <= 'b1;
                dout_reg_end = 'b0;
            end
        9: begin
                dout_reg <= 'b0;
                dout_reg_end = 'b0;
        endcase
    end
    reg [31:0] dout_val;
    always @(posedge clk) begin
        case (state)
            0: dout_val <= 'b1;
            1: dout_val <= 'b1;
            2: dout_val <= 'b0;
            3: dout_val <= 'b0;
            4: dout_val <= 'b1;
            5: dout_val <= 'b0;
            6: dout_val <= 'b1;
            7: dout_val <= 'b0;
            8: dout_val <= 'b1;
            9: dout_val <= 'b0;
        endcase
    end
endmodule

