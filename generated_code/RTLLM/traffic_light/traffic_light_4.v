
module traffic_light(
    input rst_n,
    input clk,
    input pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

// Parameters
parameter idle = 2'b00;
parameter s1_red = 2'b01;
parameter s2_yellow = 2'b10;
parameter s3_green = 2'b11;

// Registers
reg [1:0] state;
reg [7:0] cnt;
reg p_red, p_yellow, p_green;

// State transition logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
        cnt <= 10;
    end else begin
        case (state)
            idle: begin
                state <= s1_red;
            end
            s1_red: begin
                if (cnt == 3) begin
                    state <= s3_green;
                    cnt <= 60;
                end else begin
                    state <= s1_red;
                end
            end
            s2_yellow: begin
                if (cnt == 3) begin
                    state <= s1_red;
                    cnt <= 5;
                end else begin
                    state <= s2_yellow;
                end
            end
            s3_green: begin
                if (cnt == 3) begin
                    state <= s2_yellow;
                    cnt <= 10;
                end else begin
                    state <= s3_green;
                end
            end
        endcase
    end
end

// Counter logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 10;
    end else begin
        if (pass_request && p_green) begin
            cnt <= 10;
        end else if (!green && p_green) begin
            cnt <= 60;
        end else if (!yellow && p_yellow) begin
            cnt <= 5;
        end else if (!red && p_red) begin
            cnt <= 10;
        end else begin
            cnt <= cnt - 1;
        end
    end
end

// Output logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        red <= 0;
        yellow <= 0;
        green <= 0;
    end else begin
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;

        case (state)
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

// Assign clock output
assign clock = cnt;

endmodule