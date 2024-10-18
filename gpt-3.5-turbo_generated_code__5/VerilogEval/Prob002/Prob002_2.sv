
module TopModule(
    output reg out
    );

// Always drive 0 (logic low) on the output port
always @(*) begin
    out = 0;
end

endmodule