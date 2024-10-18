
module TopModule (
  input in,
  output out
);
  
  assign out = ~in;  // NOT gate implementation
  
endmodule
module Testbench;
  
  reg in;
  wire out;
  
  TopModule uut (
    .in(in),
    .out(out)
  );
  
  initial begin
    #10 in = 1'b0;  // Set input to 0
    #10 in = 1'b1;  // Set input to 1
    #10 $finish;    // Finish simulation
  end
  
endmodule