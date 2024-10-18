
module pulse_detect(
    input wire clk,
    input wire rst_n,
    input wire data_in,
    output reg data_out
);

// Define states for pulse detection
parameter IDLE = 2'b00;
parameter HIGH = 2'b01;
parameter LOW = 2'b10;
reg [1:0] state;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data_in) begin
                    state <= HIGH;
                end
            end
            HIGH: begin
                if (!data_in) begin
                    state <= LOW;
                end
            end
            LOW: begin
                if (data_in) begin
                    state <= IDLE;
                    data_out <= 1;
                end
            end
        endcase
    end
end
endmodule