
module mux( 
  input [4:0] a, b,
  input sel,
  output reg [4:0] out );

  always @ (a, b, sel)
  begin
    if(sel)
      out = b;
    else
      out = a;
  end

endmodule