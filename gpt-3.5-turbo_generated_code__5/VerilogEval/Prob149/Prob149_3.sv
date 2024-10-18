
module TopModule(
    input clk,
    input reset,
    input [2:0] s,
    output fr2,
    output fr1,
    output fr0,
    output dfr
);

// Define states for the state machine
parameter IDLE = 2'b00;
parameter ABOVE_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BETWEEN_S1_S0 = 2'b11;

reg [1:0] state;
reg [1:0] prev_state;
reg [1:0] prev_water_level;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        prev_state <= IDLE;
        prev_water_level <= 2'b00;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        fr0 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            IDLE:
                if (s[2]) begin
                    state <= ABOVE_S2;
                end
                else if (s[1]) begin
                    state <= BETWEEN_S2_S1;
                end
                else if (s[0]) begin
                    state <= BETWEEN_S1_S0;
                end
                else begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end

            ABOVE_S2:
                if (!s[2]) begin
                    state <= IDLE;
                end

            BETWEEN_S2_S1:
                if (!s[1]) begin
                    state <= IDLE;
                end

            BETWEEN_S1_S0:
                if (!s[0]) begin
                    state <= IDLE;
                end
        endcase
    end
end

always @* begin
    case ({s, prev_water_level})
        3'b100: // Above s[2]
            fr2 = 1'b0;
            fr1 = 1'b0;
            fr0 = 1'b0;
            dfr = 1'b0;
        3'b011: // Between s[2] and s[1]
            fr2 = 1'b0;
            fr1 = 1'b0;
            fr0 = 1'b1;
            dfr = prev_state == ABOVE_S2 ? 1'b1 : 1'b0;
        3'b010: // Between s[1] and s[0]
            fr2 = 1'b0;
            fr1 = 1'b1;
            fr0 = 1'b1;
            dfr = prev_state == BETWEEN_S2_S1 ? 1'b1 : 1'b0;
        3'b001: // Below s[0]
            fr2 = 1'b1;
            fr1 = 1'b1;
            fr0 = 1'b1;
            dfr = prev_state == BETWEEN_S1_S0 ? 1'b1 : 1'b0;
    endcase
end

always @(posedge clk) begin
    prev_state <= state;
    prev_water_level <= s;
end

endmodule