
module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

// Declare states for pulse detection process
parameter INIT = 2'b00;
parameter STATE1 = 2'b01;
parameter STATE2 = 2'b10;
parameter STATE3 = 2'b11;

// Declare register to keep track of current state
reg [1:0] state;

// Initial values
initial begin
    state = INIT;
    data_out = 0;
end

// Always block for pulse detection process
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= INIT;
        data_out <= 0;
    end
    else begin
        case (state)
            INIT: begin
                if (data_in) begin
                    state <= STATE1;
                end
            end
            STATE1: begin
                if (!data_in) begin
                    state <= STATE2;
                end
                else begin
                    state <= INIT;
                end
            end
            STATE2: begin
                if (data_in) begin
                    state <= STATE3;
                end
                else begin
                    state <= INIT;
                end
            end
            STATE3: begin
                if (!data_in) begin
                    state <= INIT;
                    data_out <= 1;
                end
            end
        endcase
        if (state != STATE3) begin
            data_out <= 0;
        end
    end
end

endmodule