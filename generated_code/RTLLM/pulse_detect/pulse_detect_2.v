
module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

// State declaration
reg [2:0] state;

// State definitions
parameter IDLE = 3'b000;
parameter STATE_A = 3'b001;
parameter STATE_B = 3'b010;
parameter STATE_C = 3'b011;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data_in) begin
                    state <= STATE_A;
                end
            end
            STATE_A: begin
                if (!data_in) begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                if (data_in) begin
                    state <= STATE_C;
                end
            end
            STATE_C: begin
                if (!data_in) begin
                    state <= IDLE;
                    data_out <= 1;
                end
            end
        endcase
    end
end

endmodule