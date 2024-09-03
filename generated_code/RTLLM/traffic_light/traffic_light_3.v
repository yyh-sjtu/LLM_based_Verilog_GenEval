module traffic_light(
    input wire rst_n,
    input wire clk,
    input wire pass_request,
    output reg [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);

parameter idle = 2'b00;
parameter s1_red = 2'b01;
parameter s2_yellow = 2'b10;
parameter s3_green = 2'b11;

reg [7:0] cnt;
reg [1:0] state;
reg p_red, p_yellow, p_green;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 8'b00001010; // 10 in binary
        state <= idle;
        p_red <= 1'b0;
        p_yellow <= 1'b0;
        p_green <= 1'b0;
    end else begin
        case(state)
            idle: begin
                state <= s1_red;
            end
            s1_red: begin
                if(cnt == 8'b00000011) begin // 3 in binary
                    state <= s3_green;
                end
            end
            s2_yellow: begin
                if(cnt == 8'b00000011) begin // 3 in binary
                    state <= s1_red;
                end
            end
            s3_green: begin
                if(cnt == 8'b00000011) begin // 3 in binary
                    state <= s2_yellow;
                end
            end
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 8'b00001010; // 10 in binary
    end else begin
        if(pass_request && p_green) begin
            cnt <= 8'b00001010; // 10 in binary
        end else if(!p_green && p_green) begin
            cnt <= 8'b00111100; // 60 in binary
        end else if(!p_yellow && p_yellow) begin
            cnt <= 8'b00000101; // 5 in binary
        else if(!p_red && p_red) begin
            cnt <= 8'b00001010; // 10 in binary
        end else begin
            cnt <= cnt - 8'b00000001; // Decrement counter
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
        case(state)
            s1_red: begin
                red <= 1'b1;
                yellow <= 1'b0;
                green <= 1'b0;
            end
            s2_yellow: begin
                red <= 1'b0;
                yellow <= 1'b1;
                green <= 1'b0;
            end
            s3_green: begin
                red <= 1'b0;
                yellow <= 1'b0;
                green <= 1'b1;
            end
        endcase
        p_red <= red;
        p_yellow <= yellow;
        p_green <= green;
    end
end

endmodule

