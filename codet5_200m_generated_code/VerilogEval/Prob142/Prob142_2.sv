module TopModule (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);
parameter WIDTH = 8;
wire [WIDTH-1:0] state;
reg [WIDTH-1:0] b;
reg [WIDTH-1:0] c;
wire [WIDTH-1:0] v;
wire [WIDTH-1:0] u;
wire [WIDTH-1:0] u_v;
wire [WIDTH-1:0] u_v_w;
wire [WIDTH-1:0] u_v_w;
wire [WIDTH-1:0] u_v_w;
wire [WIDTH-1:0] u_v_w;
wire [WIDTH-1:0] u_v_w;
wire u_v_w;
assign aaah = 1'b1;
assign walk_left = 1'b1;
assign walk_right = 1'b1;
assign u_v_w = 'b0;
assign u_v_w = 'b0;
assign u_v_w = 'b0;
always @(posedge clk) begin
    if (areset) begin
        b <= 'b0;
        c <= 'b0;
        u <= 'b0;
        u_v <= 'b0;
        u_v_w <= 'b0;
        u_v_w <= 'b0;
        u_v_w <= 'b0;
    end else begin
        case (state)
            2'd0: begin
                b <= 1'b0;
                c <= 'b1;
                u <= 'b0;
                u_v <= 'b0;
                u_v_w <= 'b0;
                u_v_w <= 'b0;
            end
            2'd1: begin
                b <= 1'b1;
                c <= 'b1;
                u <= 'b0;
                u_v_w <= 'b0;
            end
            2'd2: begin
                b <= 1'b1;
                c <= 'b1;
                u <= 'b1;
                u_v_w <= 'b0;
            end
            default: begin
                b <= 1'b0;
                c <= 'b0;
                u <= 'b0;
                u_v_w <= 'b0;
                u_v_w <= 'b0;
                u_v_w <= 'b0;
            end
        endcase
    end
end
endmodule

