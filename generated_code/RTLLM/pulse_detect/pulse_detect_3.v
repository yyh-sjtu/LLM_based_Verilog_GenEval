
module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

// Declare state register to keep track of pulse detection process
reg [2:0] state;

// Define states for pulse detection process
parameter IDLE = 3'b000;
parameter STATE1 = 3'b001;
parameter STATE2 = 3'b010;
parameter STATE3 = 3'b011;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end
    else begin
        case(state)
            IDLE: begin
                if (data_in == 1)
                    state <= STATE1;
            end
            STATE1: begin
                if (data_in == 0)
                    state <= STATE2;
                else
                    state <= IDLE;
            end
            STATE2: begin
                if (data_in == 1)
                    state <= STATE3;
                else
                    state <= IDLE;
            end
            STATE3: begin
                state <= IDLE;
                data_out <= 1;
            end
        endcase
    end
end

endmodule