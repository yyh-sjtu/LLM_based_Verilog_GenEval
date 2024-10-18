module traffic_light (
    input rst_n, // Reset signal (active low)
    input clk, // Clock signal
    input pass_request, // Request signal for allowing vehicles to pass
    output reg [7:0] clock, // 8-bit output representing the count value of the internal counter
    output reg red, // Output signal representing the state of the red traffic light
    output reg yellow, // Output signal representing the state of the yellow traffic light
    output reg green // Output signal representing the state of the green traffic light
);

// Parameters
parameter idle = 2'd0;
parameter s1_red = 2'd1;
parameter s2_yellow = 2'd2;
parameter s3_green = 2'd3;

// Registers
reg [7:0] cnt; // 8-bit register used as an internal counter for timing purposes
reg [1:0] state; // 2-bit register representing the current state of the traffic light controller
reg p_red, p_yellow, p_green; // 1-bit registers representing the previous values for the red, yellow, and green signals

// Always block for state transition logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
    end else begin
        case (state)
            idle: begin
                state <= s1_red;
            end
            s1_red: begin
                if (cnt == 3) begin
                    state <= s3_green;
                end
            end
            s2_yellow: begin
                if (cnt == 3) begin
                    state <= s1_red;
                end
            end
            s3_green: begin
                if (cnt == 3) begin
                    state <= s2_yellow;
                end
            end
        endcase
    end
end

// Always block for counting logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 10;
    end else begin
        if (pass_request && p_green) begin
            cnt <= 10;
        end else begin
            case (state)
                s1_red: begin
                    if (cnt == 0) begin
                        cnt <= 60;
                    end else begin
                        cnt <= cnt - 1;
                    end
                end
                s2_yellow: begin
                    if (cnt == 0) begin
                        cnt <= 5;
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
            endcase
        end
    end
end

// Assign statement for output clock
assign clock = cnt;

// Always block for output signals
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        red <= 0;
        yellow <= 0;
        green <= 0;
    end else begin
        red <= p_red;
        yellow <= p_yellow;
        green <= p_green;
        case (state)
            s1_red: begin
                red <= 1;
            end
            s2_yellow: begin
                yellow <= 1;
            end
            s3_green: begin
                green <= 1;
            end
        endcase
    end
end

endmodule

