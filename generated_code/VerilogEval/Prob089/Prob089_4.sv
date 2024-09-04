
module TopModule (
    input clk,
    input areset,
    input x,
    output reg z
);

// State declaration
reg [1:0] state;
parameter S_IDLE = 2'b00;
parameter S_CONVERT = 2'b01;

// Sequential logic
always @(posedge clk) begin
    if (areset) begin
        state <= S_IDLE;
        z <= 1'b0;
    end else begin
        case(state)
            S_IDLE: begin
                if (!areset && x == 1'b1) begin
                    state <= S_CONVERT;
                    z <= ~x; // 2's complement of input x
                end
            end
            S_CONVERT: begin
                if (!areset && x == 1'b0) begin
                    state <= S_IDLE;
                    z <= 1'b0;
                end
            end
        endcase
    end
end

endmodule