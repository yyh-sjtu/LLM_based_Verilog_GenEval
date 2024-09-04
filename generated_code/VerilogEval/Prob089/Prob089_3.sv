
module TopModule (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definition
localparam IDLE = 2'b00;
localparam COMPLEMENT = 2'b01;

reg [1:0] state, next_state;

always @ (posedge clk or posedge areset)
begin
    if (areset)
        state <= IDLE;
    else
        state <= next_state;
end

always @ *
begin
    next_state = state;

    case (state)
        IDLE:
        begin
            if (!areset)
            begin
                if (x)
                    next_state = COMPLEMENT;
            end
        end

        COMPLEMENT:
        begin
            if (!areset)
                next_state = COMPLEMENT;
        end
    endcase
end

always @ (posedge clk)
begin
    case (state)
        IDLE:
        begin
            z <= 1'b0;
        end

        COMPLEMENT:
        begin
            z <= ~x;
        end
    endcase
end

endmodule