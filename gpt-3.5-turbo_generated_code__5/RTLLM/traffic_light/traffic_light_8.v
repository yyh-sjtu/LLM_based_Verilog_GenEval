
module traffic_light(
    input rst_n, // Reset signal
    input clk, // Clock signal
    input pass_request, // Request signal for allowing vehicles to pass
    output reg [7:0] clock, // 8-bit output representing the count value of the internal counter
    output reg red, // Output signal representing the state of the red traffic light
    output reg yellow, // Output signal representing the state of the yellow traffic light
    output reg green // Output signal representing the state of the green traffic light
);

// Parameter declaration
parameter idle = 2'b00;
parameter s1_red = 2'b01;
parameter s2_yellow = 2'b10;
parameter s3_green = 2'b11;

// Registers
reg [7:0] cnt; // Internal counter for timing purposes
reg [1:0] state; // Current state of the traffic light controller
reg p_red, p_yellow, p_green; // Next values for the red, yellow, and green signals

// State transition logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
        p_red <= 1'b0;
        p_yellow <= 1'b0;
        p_green <= 1'b0;
    end
    else begin
        case(state)
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
                end
            end
            s2_yellow: begin
                yellow <= 1'b1;
                if (cnt == 3) begin
                    state <= s1_red;
                end
            end
            s3_green: begin
                green <= 1'b1;
                if (cnt == 3) begin
                    state <= s2_yellow;
                end
            end
        endcase
    end
end

// Counting logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 10;
    end
    else begin
        if (pass_request && green) begin
            cnt <= 10;
        end
        else if (!p_green && green) begin
            cnt <= 60;
        end
        else if (!p_yellow && yellow) begin
            cnt <= 5;
        end
        else if (!p_red && red) begin
            cnt <= 10;
        end
        else begin
            cnt <= cnt - 1;
        end
    end
end

// Output logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        p_red <= 1'b0;
        p_yellow <= 1'b0;
        p_green <= 1'b0;
    end
    else begin
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;
    end
end

// Assign internal counter to clock output
assign clock = cnt;

endmodule