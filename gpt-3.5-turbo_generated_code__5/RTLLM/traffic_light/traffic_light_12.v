module traffic_light (
    input rst_n,
    input clk,
    input pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

    // Enumeration values for different states
    parameter idle = 2'b00;
    parameter s1_red = 2'b01;
    parameter s2_yellow = 2'b10;
    parameter s3_green = 2'b11;

    // Internal registers
    reg [7:0] cnt;
    reg [1:0] state;
    reg p_red, p_yellow, p_green;

    // State transition logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= idle;
        end else begin
            case (state)
                idle: begin
                    red <= 0;
                    yellow <= 0;
                    green <= 0;
                    state <= s1_red;
                end
                s1_red: begin
                    red <= 1;
                    if (cnt == 3) begin
                        cnt <= 0;
                        state <= s3_green;
                    end
                end
                s2_yellow: begin
                    yellow <= 1;
                    if (cnt == 3) begin
                        cnt <= 0;
                        state <= s1_red;
                    end
                end
                s3_green: begin
                    green <= 1;
                    if (cnt == 3) begin
                        cnt <= 0;
                        state <= s2_yellow;
                    end
                end
            endcase
        end
    end

    // Counting logic for internal counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 10;
        end else begin
            if (pass_request && green) begin
                cnt <= 10;
            end else if (!green && p_green) begin
                cnt <= 60;
            end else if (!yellow && p_yellow) begin
                cnt <= 5;
            end else if (!red && p_red) begin
                cnt <= 10;
            end else begin
                if (cnt > 0) begin
                    cnt <= cnt - 1;
                end
            end
        end
    end

    // Assign internal counter value to clock output
    assign clock = cnt;

    // Output signal assignment
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
    end

endmodule

