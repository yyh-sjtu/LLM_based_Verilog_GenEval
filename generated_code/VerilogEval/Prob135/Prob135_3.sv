
module TopModule (
    input  [2:0] y,   // 3-bit input representing current state
    input        w,    // 1-bit input
    output       Y1    // 1-bit output representing y[1]
);

    // Next State Logic for y[2:0]
    reg [2:0] next_state;
    
    always @(*) begin
        case (y)
            3'b000: next_state = (w) ? 3'b000 : 3'b001; // A --0--> B, A --1--> A
            3'b001: next_state = (w) ? 3'b011 : 3'b010; // B --0--> C, B --1--> D
            3'b010: next_state = (w) ? 3'b011 : 3'b100; // C --0--> E, C --1--> D
            3'b011: next_state = (w) ? 3'b000 : 3'b101; // D --0--> F, D --1--> A
            3'b100: next_state = (w) ? 3'b011 : 3'b100; // E --0--> E, E --1--> D
            3'b101: next_state = (w) ? 3'b010 : 3'b011; // F --0--> C, F --1--> D
            default: next_state = 3'b000; // Default to state A
        endcase
    end
    
    // Output logic for Y1
    assign Y1 = next_state[1]; // Y1 is y[1] of the next state

endmodule