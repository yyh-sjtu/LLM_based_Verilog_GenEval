module traffic_light (
    input wire rst_n,
    input wire clk,
    input wire pass_request,
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
reg [7:0] cnt;
reg [1:0] state;
reg p_red, p_yellow, p_green;

// State transition logic
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
    end else begin
        case (state)
            idle: begin
                red <= 1'b0;
                yellow <= 1'b0;
                green <= 1'b0;
                state <= s1_red;
            end
            s1_red: begin
                red <= 1'b1;
                if (cnt == 3) begin
                    state <= s3_green;
                    cnt <= 0;
                end else begin
                    state <= s1_red;
                end
            end
            s2_yellow: begin
                yellow <= 1'b1;
                if (cnt == 3) begin
                    state <= s1_red;
                    cnt <= 0;
                end else begin
                    state <= s2_yellow;
                end
            end
            s3_green: begin
                green <= 1'b1;
                if (cnt == 3) begin
                    state <= s2_yellow;
                    cnt <= 0;
                end else begin
                    state <= s3_green;
                end
            end
        endcase
    end
end

// Counting logic
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 10;
    end else begin
        case (state)
            s1_red: begin
                if (cnt == 0) begin
                    cnt <= 3;
                end else begin
                    cnt <= cnt - 1;
                end
            end
            s2_yellow: begin
                if (cnt == 0) begin
                    cnt <= 3;
                end else begin
                    cnt <= cnt - 1;
                end
            end
            s3_green: begin
                if (cnt == 0) begin
                    cnt <= 3;
                end else begin
                    cnt <= cnt - 1;
                end
            end
            default: begin
                if (pass_request && green) begin
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
        endcase
    end
end

// Output logic
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        p_red <= 1'b0;
        p_yellow <= 1'b0;
        p_green <= 1'b0;
    end else begin
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;
        red <= p_red;
        yellow <= p_yellow;
        green <= p_green;
    end
end

// Assign counter value to output
assign clock = cnt;

endmodule

