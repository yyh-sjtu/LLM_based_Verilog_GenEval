
module TopModule (
    input  clk,
    input  reset,
    input  [2:0] s,
    output reg fr2,
    output reg fr1,
    output reg fr0,
    output reg dfr
);

    // State variables
    reg [2:0] prev_s; // To hold the previous sensor state

    // State encoding
    localparam STATE_LOW    = 3'b000; // Below s[0]
    localparam STATE_MED1   = 3'b001; // Between s[0] and s[1]
    localparam STATE_MED2   = 3'b010; // Between s[1] and s[2]
    localparam STATE_HIGH   = 3'b011; // Above s[2]

    // State register to record the current state based on sensor inputs
    reg [1:0] current_state;

    // Process to handle state transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to low state
            fr2 <= 1;
            fr1 <= 1;
            fr0 <= 1;
            dfr <= 1;
            prev_s <= 3'b000; // Assume lowest state
            current_state <= STATE_LOW; // Reset state
        end else begin
            // Determine current state based on sensors
            if (s[2]) begin // Above s[2]
                current_state <= STATE_HIGH;
            end else if (s[1]) begin // Between s[2] and s[1]
                current_state <= STATE_MED2;
            end else if (s[0]) begin // Between s[1] and s[0]
                current_state <= STATE_MED1;
            end else begin // Below s[0]
                current_state <= STATE_LOW;
            end

            // FSM based on current state
            case (current_state)
                STATE_LOW: begin
                    // Below s[0] - open all flow valves
                    fr2 <= 1;
                    fr1 <= 1;
                    fr0 <= 1;
                    dfr <= 1; // Supplemental flow valve should be on
                end

                STATE_MED1: begin
                    // Between s[0] and s[1]
                    fr2 <= 0;
                    fr1 <= 1;
                    fr0 <= 1;
                    dfr <= (prev_s < 1); // Previous state check for sup. flow
                end

                STATE_MED2: begin
                    // Between s[1] and s[2]
                    fr2 <= 0;
                    fr1 <= 0;
                    fr0 <= 1;
                    dfr <= (prev_s < 2); // Previous state check for sup. flow
                end

                STATE_HIGH: begin
                    // Above s[2] - no flow
                    fr2 <= 0;
                    fr1 <= 0;
                    fr0 <= 0;
                    dfr <= 0;
                end

            endcase

            // Update previous sensor state
            prev_s <= s;
        end
    end
endmodule