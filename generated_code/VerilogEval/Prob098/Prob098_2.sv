
module TopModule (
    input clk,
    input a,
    output reg q
);

// State machine definition
reg state;

// Initial state
always @ (posedge clk) begin
    if (state) begin
        if (!a)
            q <= 1;
        else 
            q <= 0;
    end
    else begin
        q <= 0;
    end
end

// Next state logic
always @ (posedge clk) begin
    case (state)
        1: begin
            if (!a)
                state <= 1;
            else
                state <= 0;
        end
        default: begin
            if (a)
                state <= 1;
        end
    endcase
end

endmodule