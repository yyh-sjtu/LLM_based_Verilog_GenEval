module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

// Define states for pulse detection
parameter IDLE = 2'b00;
parameter FIRST_HIGH = 2'b01;
parameter SECOND_LOW = 2'b10;

// State register
reg [1:0] state;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data_in) state <= FIRST_HIGH;
            end
            FIRST_HIGH: begin
                if (~data_in) state <= SECOND_LOW;
            end
            SECOND_LOW: begin
                if (data_in) begin
                    state <= IDLE;
                    data_out <= 1;
                end
            end
        endcase
    end
end

endmodule

