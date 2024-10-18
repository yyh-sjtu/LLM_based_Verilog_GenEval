
module TopModule(
  input c,
  input d,
  output [3:0] mux_in
);

  wire a, b;
  
  // Logic for a and b inputs of the multiplexers based on c and d inputs
  assign a = ~c & ~d;
  assign b = ~c & d;
  
  // Implementing the Karnaugh map using multiplexers
  assign mux_in[0] = (~b & ~a) & 1'b1; // cd = 00
  assign mux_in[1] = (~b & a) & 1'b1;  // cd = 01
  assign mux_in[2] = (b & a) & 1'b1;   // cd = 11
  assign mux_in[3] = (b & ~a) & 1'b1;  // cd = 10

endmodule