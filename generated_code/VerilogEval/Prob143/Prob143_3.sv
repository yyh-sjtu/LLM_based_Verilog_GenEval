
module TopModule (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

// Assign default values to outputs
always @*
begin
    out1 = 0;
    out2 = 0;
end

// State transition logic
always @*
begin
    case(state)
        10'h001: begin // S0
            next_state = in ? 10'h002 : 10'h001;
        end
        10'h002: begin // S1
            next_state = in ? 10'h003 : 10'h001;
        end
        10'h003: begin // S2
            next_state = in ? 10'h004 : 10'h001;
        end
        10'h004: begin // S3
            next_state = in ? 10'h005 : 10'h001;
        end
        10'h005: begin // S4
            next_state = in ? 10'h006 : 10'h008;
        end
        10'h006: begin // S5
            next_state = in ? 10'h007 : 10'h009;
        end
        10'h007: begin // S6
            next_state = in ? 10'h007 : 10'h001;
        end
        10'h008: begin // S7
            next_state = in ? 10'h007 : 10'h007;
        end
        10'h009: begin // S8
            next_state = in ? 10'h002 : 10'h001;
        end
        default: next_state = 10'h001;
    endcase
end

// Output logic
always @*
begin
    case(state)
        10'h005: begin // S4
            out1 = 1;
        end
        10'h006: begin // S5
            out2 = 1;
        end
        10'h009: begin // S8
            out1 = 1;
        end
        10'h009: begin // S9
            out2 = 1;
        end
        default: begin
            out1 = 0;
            out2 = 0;
        end
    endcase
end

endmodule