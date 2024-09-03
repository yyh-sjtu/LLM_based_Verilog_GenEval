
module traffic_light (
    input rst_n,
    input clk,
    input pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

    typedef enum logic [1:0] {
        idle = 2'b00,
        s1_red = 2'b01,
        s2_yellow = 2'b10,
        s3_green = 2'b11
    } state_type;

    reg [7:0] cnt;
    reg [1:0] state, next_state;
    reg p_red, p_yellow, p_green;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 8'd10;
            state <= idle;
        end else begin
            case (state)
                idle: begin
                    p_red <= 1'b0;
                    p_yellow <= 1'b0;
                    p_green <= 1'b0;
                    next_state <= s1_red;
                end
                s1_red: begin
                    p_red <= 1'b1;
                    p_yellow <= 1'b0;
                    p_green <= 1'b0;
                    if (cnt == 8'd3) begin
                        next_state <= s3_green;
                    end else begin
                        next_state <= s1_red;
                    end
                end
                s2_yellow: begin
                    p_red <= 1'b0;
                    p_yellow <= 1'b1;
                    p_green <= 1'b0;
                    if (cnt == 8'd3) begin
                        next_state <= s1_red;
                    end else begin
                        next_state <= s2_yellow;
                    end
                end
                s3_green: begin
                    p_red <= 1'b0;
                    p_yellow <= 1'b0;
                    p_green <= 1'b1;
                    if (cnt == 8'd3) begin
                        next_state <= s2_yellow;
                    end else begin
                        next_state <= s3_green;
                    end
                end
                default: next_state <= idle; // The default case should not happen
            endcase
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 8'd10;
        end else begin
            if (pass_request && p_green) begin
                cnt <= 8'd10;
            end else if (!p_green && p_yellow) begin
                cnt <= 8'd60;
            end else if (!p_yellow && p_red) begin
                cnt <= 8'd5;
            end else if (!p_red && (state == s1_red)) begin
                cnt <= 8'd10;
            end else begin
                cnt <= cnt - 1;
            end
        end
    end

    assign clock = cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            red <= 1'b0;
            yellow <= 1'b0;
            green <= 1'b0;
        end else begin
            red <= p_red;
            yellow <= p_yellow;
            green <= p_green;
        end
    end

endmodule