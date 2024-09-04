
module TopModule (
    input [2:0] y,
    input w,
    output reg Y1
);

reg [2:0] state;

// Next-state logic
always @(*) begin
    case(state)
        3'b000: begin // State A
            if (w)
                state <= 3'b000; // A (0) --1--> A
            else
                state <= 3'b001; // A (0) --0--> B
        end
        3'b001: begin // State B
            if (w)
                state <= 3'b011; // B (0) --1--> D
            else
                state <= 3'b010; // B (0) --0--> C
        end
        3'b010: begin // State C
            if (w)
                state <= 3'b011; // C (0) --1--> D
            else
                state <= 3'b100; // C (0) --0--> E
        end
        3'b011: begin // State D
            if (w)
                state <= 3'b001; // D (0) --1--> A
            else
                state <= 3'b101; // D (0) --0--> F
        end
        3'b100: begin // State E
            if (w)
                state <= 3'b011; // E (1) --1--> D
            else
                state <= 3'b100; // E (1) --0--> E
        end
        3'b101: begin // State F
            if (w)
                state <= 3'b011; // F (1) --1--> D
            else
                state <= 3'b010; // F (1) --0--> C
        end
        default: state <= 3'b000; // Default case state A
    endcase
end

// Output logic
always @(*) begin
    if (state == 3'b001 || state == 3'b011 || state == 3'b101)
        Y1 = 1;
    else
        Y1 = 0;
end


endmodule