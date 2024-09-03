module

//Instance of lfsr module
module test_lfsr;
reg clk;
reg reset;
wire [4:0] q;

initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
    #50 $finish; // End simulation after 50 time units
end

always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
end

lfsr uut (
    .clk(clk),
    .reset(reset),
    .q(q)
);

endmodule

