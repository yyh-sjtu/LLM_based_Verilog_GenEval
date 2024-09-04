
module TopModule (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition and output logic equations
always @* begin
    case(state)
        4'b0001: begin // State A
            if(in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b0001; // Next state A
            out = 1'b0;
        end
        4'b0010: begin // State B
            if(in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b0100; // Next state C
            out = 1'b0;
        end
        4'b0100: begin // State C
            if(in)
                next_state = 4'b1000; // Next state D
            else
                next_state = 4'b0001; // Next state A
            out = 1'b0;
        end
        4'b1000: begin // State D
            if(in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b1000; // Next state D
            out = 1'b1;
        end
        default: begin
            next_state = state;
            out = 1'b0;
        end
    endcase
end

endmodule