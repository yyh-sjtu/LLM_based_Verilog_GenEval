module top_module (
    input [15:0] in,
    output reg [7:0] out_hi,
    output reg [7:0] out_lo
);

    // Assign the lower byte [7:0] to out_lo
    assign out_lo = in[7:0];
    
    // Assign the upper byte [15:8] to out_hi
    assign out_hi = in[15:8];
    
endmodule

