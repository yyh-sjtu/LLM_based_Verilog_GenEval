
module TopModule (
    input   [3:0] in,  // 4-bit input
    output  [1:0] pos  // 2-bit output
);
    
    // Internal signal to hold the output
    reg [1:0] position;
    
    // Always block for combinational logic
    always @(*) begin
        casez (in) // casez allows for don't care conditions
            4'b1???: position = 2'd3; // If in[3] is high
            4'b01??: position = 2'd2; // If in[2] is high
            4'b001?: position = 2'd1; // If in[1] is high
            4'b0001: position = 2'd0; // If in[0] is high
            default: position = 2'd0;   // If none are high
        endcase
    end
    
    // Assign the computed position to the output
    assign pos = position;

endmodule