
module TopModule (
    input  clk,
    input  j,
    input  k,
    output reg Q
);

// A register to hold the previous state (Qold)
reg Qold;

always @(posedge clk) begin
    // Assign Qold to the current Q for the next clock cycle
    Qold <= Q; 
    case ({j, k})
        2'b00: Q <= Qold; // Maintain current state
        2'b01: Q <= 1'b0; // Reset
        2'b10: Q <= 1'b1; // Set
        2'b11: Q <= ~Qold; // Toggle
    endcase
end

endmodule