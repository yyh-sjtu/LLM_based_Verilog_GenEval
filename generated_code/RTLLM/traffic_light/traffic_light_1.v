
module traffic_light (
    input rst_n,
    input clk,
    input pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

parameter idle = 2'b00, s1_red = 2'b01, s2_yellow = 2'b10, s3_green = 2'b11;

reg [1:0] state;
reg [1:0] next_state;
reg [7:0] cnt;
reg p_red;
reg p_yellow;
reg p_green;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        cnt <= 10;
    else begin
        case(state)
            idle: begin
                next_state <= s1_red;
            end
            s1_red: begin
                next_state <= (cnt == 3) ? s3_green : s1_red;
            end
            s2_yellow: begin
                next_state <= (cnt == 3) ? s1_red : s2_yellow;
            end
            s3_green: begin
                next_state <= (cnt == 3) ? s2_yellow : s3_green;
            end
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        cnt <= 10;
    else begin
        if (pass_request && p_green)
            cnt <= 10;
        else if (!p_green && green)
            cnt <= 60;
        else if (!p_yellow && yellow)
            cnt <= 5;
        else if (!p_red && red)
            cnt <= 10;
        else
            cnt <= cnt - 1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
        red <= 0;
        yellow <= 0;
        green <= 0;
    end else begin
        state <= next_state;
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;

        case(state)
            idle: begin
                red <= 0;
                yellow <= 0;
                green <= 0;
            end
            s1_red: begin
                red <= 1;
                yellow <= 0;
                green <= 0;
            end
            s2_yellow: begin
                red <= 0;
                yellow <= 1;
                green <= 0;
            end
            s3_green: begin
                red <= 0;
                yellow <= 0;
                green <= 1;
            end
        endcase
    end
end

assign clock = cnt;

endmodule