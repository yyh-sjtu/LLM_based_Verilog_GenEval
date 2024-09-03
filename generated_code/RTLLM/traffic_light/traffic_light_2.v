module traffic_light(
    input rst_n,
    input clk,
    input pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

// Enumeration values for states
parameter idle = 2'b00;
parameter s1_red = 2'b01;
parameter s2_yellow = 2'b10;
parameter s3_green = 2'b11;

// Internal registers for state and counters
reg [1:0] state;
reg [7:0] cnt;
reg p_red, p_yellow, p_green;

// State transition logic
always @ (posedge clk or negedge rst_n)
begin
    if (!rst_n)
        state <= idle;
    else
    begin
        case(state)
            idle: state <= s1_red;
            s1_red: state <= (cnt == 3) ? s3_green : s1_red;
            s2_yellow: state <= (cnt == 3) ? s1_red : s2_yellow;
            s3_green: state <= (cnt == 3) ? s2_yellow : s3_green;
        endcase
    end
end

// Counting logic
always @ (posedge clk or negedge rst_n)
begin
    if (!rst_n)
        cnt <= 10;
    else if (pass_request && p_green)
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

// Output assignment logic
always @ (posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        red <= 0;
        yellow <= 0;
        green <= 0;
    end
    else
    begin
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;
        
        case(state)
            idle: begin red <= 0; yellow <= 0; green <= 0; end
            s1_red: begin red <= 1; yellow <= 0; green <= 0; end
            s2_yellow: begin red <= 0; yellow <= 1; green <= 0; end
            s3_green: begin red <= 0; yellow <= 0; green <= 1; end
        endcase
    end
end

// Output assignment for clock signal
assign clock = cnt;

endmodule

