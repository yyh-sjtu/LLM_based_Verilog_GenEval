
module traffic_light(
    input rst_n,
    input clk,
    input pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
    );

    typedef enum {idle, s1_red, s2_yellow, s3_green} state_type;
    reg [1:0] state, next_state;
    
    reg [7:0] cnt;
    reg [2:0] p_red, p_yellow, p_green;
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state <= idle;
            cnt <= 10;
        end else begin
            state <= next_state;
            if (cnt == 0)
                cnt <= 0;
            else
                cnt <= cnt - 1;
        end
    end
    
    always @(state, cnt, pass_request, p_red, p_yellow, p_green) begin
        case(state)
            idle: begin
                red = 0;
                yellow = 0;
                green = 0;
                next_state = s1_red;
            end

            s1_red: begin
                red = 1;
                yellow = 0;
                green = 0;
                if (cnt == 3)
                    next_state = s3_green;
                else
                    next_state = s1_red;
            end

            s2_yellow: begin
                red = 0;
                yellow = 1;
                green = 0;
                if (cnt == 3)
                    next_state = s1_red;
                else
                    next_state = s2_yellow;
            end

            s3_green: begin
                red = 0;
                yellow = 0;
                green = 1;
                if (cnt == 3)
                    next_state = s2_yellow;
                else
                    next_state = s3_green;
            end
        endcase
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            cnt <= 10;
        else if (pass_request && green)
            cnt <= 10;
        else if (!green && p_green)
            cnt <= 60;
        else if (!yellow && p_yellow)
            cnt <= 5;
        else if (!red && p_red)
            cnt <= 10;
    end
    
    assign clock = cnt;
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            p_red <= 0;
            p_yellow <= 0;
            p_green <= 0;
        end else begin
            p_red <= red;
            p_yellow <= yellow;
            p_green <= green;
        end
    end

endmodule