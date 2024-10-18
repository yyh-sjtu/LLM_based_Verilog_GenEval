module dff_pe_reset (
    input clk, // clock input
    input d,   // data input
    input ar,  // asynchronous reset input
    output reg q  // output register
);
	
always @(posedge clk, negedge ar) begin
    if (ar == 1'b0) begin
        q <= 1'b0;  // reset the output 
    end else begin
        q <= d;  // update the output with new input value
    end
end

endmodule

module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

dff_pe_reset dff (
    .clk(clk),
    .d(d),
    .ar(ar),
    .q(q)
);

endmodule

