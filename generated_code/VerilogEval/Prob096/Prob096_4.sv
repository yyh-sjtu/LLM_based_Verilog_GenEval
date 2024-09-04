
module TopModule (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// States for the finite-state machine
parameter IDLE = 2'b00;
parameter SEARCH_1 = 2'b01;
parameter SEARCH_2 = 2'b10;
parameter SHIFTING = 2'b11;

// Internal state variable
reg [1:0] state;

// Reset logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (data)
                    state <= SEARCH_1;
            end
            SEARCH_1: begin
                if (data)
                    state <= SEARCH_2;
                else
                    state <= IDLE;
            end
            SEARCH_2: begin
                if (!data)
                    state <= IDLE;
                else
                    state <= SHIFTING;
            end
            SHIFTING: begin
                start_shifting <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule