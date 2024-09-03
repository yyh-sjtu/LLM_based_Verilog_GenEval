
module traffic_light(
    input wire rst_n,
    input wire clk,
    input wire pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

// Parameters for state enumeration
parameter idle = 2'b00;
parameter s1_red = 2'b01;
parameter s2_yellow = 2'b10;
parameter s3_green = 2'b11;

// Registers and wires
reg [7:0] cnt;
reg [1:0] state;
reg p_red, p_yellow, p_green;

// State transition logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 10;
        state <= s1_red;
    end else begin
        case(state)
            idle: begin
                red <= 0;
                yellow <= 0;
                green <= 0;
                state <= s1_red;
            end
            s1_red: begin
                if (cnt == 3)
                    state <= s3_green;
                else
                    state <= s1_red;
            end
            s2_yellow: begin
                if (cnt == 3)
                    state <= s1_red;
                else
                    state <= s2_yellow;
            end
            s3_green: begin
                if (cnt == 3)
                    state <= s2_yellow;
                else
                    state <= s3_green;
            end
        endcase
    end
end

// Counting logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        cnt <= 10;
    else if (pass_request && green)
        cnt <= 10;
    else if (!green && p_green)
        cnt <= 60;
    else if (!yellow && p_yellow)
        cnt <= 5;
    else if (!red && p_red)
        cnt <= 10;
    else
        cnt <= cnt - 1;
end

// Assign internal count value to output clock
assign clock = cnt;

// Output signal logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        p_red <= 0;
        p_yellow <= 0;
        p_green <= 0;
    end else begin
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;
    end
    red <= (state == s1_red) ? 1'b1 : 1'b0;
    yellow <= (state == s2_yellow) ? 1'b1 : 1'b0;
    green <= (state == s3_green) ? 1'b1 : 1'b0;
end

endmodule