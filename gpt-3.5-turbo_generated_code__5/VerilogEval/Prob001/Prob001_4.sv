
module TopModule (
    output reg zero
);

always @(posedge your_clock) begin
    zero <= 0; // outputs a LOW (0)
end

endmodule