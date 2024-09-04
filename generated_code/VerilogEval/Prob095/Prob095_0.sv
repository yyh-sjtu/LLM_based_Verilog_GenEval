
module TopModule (
    input clk,
    input reset,
    output reg shift_ena
);

// State definitions
parameter IDLE = 2'b00;
parameter DETECTED = 2'b01;

// Registers
reg [1:0] state_reg;
reg [2:0] counter_reg;

// State and counter logic
always @(posedge clk) begin
    if (reset) begin
        state_reg <= IDLE;
        counter_reg <= 0;
        shift_ena <= 1'b0;
    end else begin
        case(state_reg)
            IDLE: begin
                if (/* condition for detecting proper bit pattern */) begin
                    state_reg <= DETECTED;
                    counter_reg <= 3; // 4 cycles - 1
                    shift_ena <= 1'b1;
                end
            end
            DETECTED: begin
                if (counter_reg > 0) begin
                    counter_reg <= counter_reg - 1;
                end else begin
                    state_reg <= IDLE;
                    shift_ena <= 1'b0;
                end
            end
            default: begin
                state_reg <= IDLE;
                counter_reg <= 0;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule