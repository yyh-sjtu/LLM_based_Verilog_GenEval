module d_ff(output q, input d, clk);
	  
   always@(posedge clk)
      q <= d;
      
endmodule

module top_module(
   input clk,
   input d,
   output reg q);
   
   d_ff d_ff_inst(.q(q), .d(d), .clk(clk));
   
endmodule

