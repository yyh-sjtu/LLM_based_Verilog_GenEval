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
reg [3:0] state;
always @(posedge clk) begin
    state <= state + 1;
end
reg [3:0] cnt;
always @(posedge clk) begin
    if (cnt == 3'd0) begin
        state <= 3'd1;
        cnt <= 3'd0;
    end
    else begin
        if (cnt == 3'd1) begin
            cnt <= 3'd1;
            state <= 3'd2;
        end
        else begin
            cnt <= cnt + 3'd1;
            state <= 3'd2;
        end
    end
end
reg [3:0] cnt_t1, cnt_t2;
reg [3:0] cnt_t3, cnt_t4, cnt_t5, cnt_t6, cnt_t7, cnt_t8;
always @(posedge clk) begin
    if (cnt == 3'd1) begin
        cnt_t1 <= 3'd0;
        cnt_t2 <= 3'd0;
        cnt_t3 <= 3'd0;
        cnt_t4 <= 3'd0;
        cnt_t5 <= 3'd0;
        cnt_t6 <= 3'd0;
        cnt_t7 <= 3'd0;
    end
    else begin
        cnt_t1 <= cnt;
        cnt_t2 <= cnt_t1;
        cnt_t3 <= cnt_t2;
        cnt_t4 <= cnt_t3;
        cnt_t5 <= cnt_t4;
        cnt_t6 <= cnt_t5;
        cnt_t7 <= cnt_t6;
        cnt_t8 <= cnt_t8;
        cnt_t9 <= cnt_t9;
        cnt_t10 <= cnt_t10;
        cnt_t11 <= cnt_t11;
        cnt_t12 <= cnt_t12;
        cnt_t13 <= cnt_t13;
        cnt_t14 <= cnt_t14;
        cnt_t15 <= cnt_t15;
        cnt_t16 <= cnt_t16;
        cnt_t17 <= cnt_t17;
        cnt_t18 <= cnt_t18;
        cnt_t19 <= cnt_t19;
        cnt_t20 <= cnt_t20;
        cnt_t21 <= cnt_t21;
        cnt_t22 <= cnt_t22;
        cnt_t23 <= cnt_t23;
        cnt_t24 <= cnt_t24;
        cnt_t25 <= cnt_t25;
        cnt_t26 <= cnt_t26;
        cnt_t27 <= cnt_t27;
        cnt_t28 <= cnt_t28;
        cnt_t29 <= cnt_t28;
        cnt_t30 <= cnt_t30;
        cnt_t31 <= cnt_t31;
        cnt_t32 <= cnt_t32;
        cnt_t34 <= cnt_t34;
        cnt_t34 <= cnt_t35;
    end
end
wire [31:0] codes;
assign codes = {bump_left, bump_right, ground, dig};
assign walk_left = ~(codes[31]);
assign walk_right = ~(codes[30]);
assign digging = (codes[31] == 0)? 1'b0 : 1'b1;
endmodule

