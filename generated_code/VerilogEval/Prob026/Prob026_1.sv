
module TopModule (
    input wire a,               // Input a
    input wire b,               // Input b
    output wire out_assign,     // Output via assign statement
    output reg out_alwaysblock  // Output via always block
);

    // Implementing the AND gate using an assign statement
    assign out_assign = a & b;

    // Implementing the AND gate using a combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule