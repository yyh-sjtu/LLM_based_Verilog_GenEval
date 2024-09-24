module TopModule (
    output reg one
);

// Always drive output one to high logic level
always @(posedge clk) begin
    one <= 1'b1;
end

endmodule

