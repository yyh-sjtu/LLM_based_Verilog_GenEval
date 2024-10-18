module shift_register(
   input clk,
   input load,
   input ena,
   input [1:0] amount,
   input [63:0] data,
   output reg [63:0] q
   );
  
   always @(posedge clk) begin
      if (load) begin
         q <= data;
      end else if (ena) begin
         case (amount)
            2'b00: q <= q << 1;  // shift left by 1 bit
            2'b01: q <= q << 8;  // shift left by 8 bits
            2'b10: q <= 64'sd(q[63]);  // shift right by 1 bit
            2'b11: q <= {56'd0, q[63:8]};  // shift right by 8 bits
         endcase
      end
   end
   
endmodule

module dut (
      .clk(clk),
      .load(load),
      .ena(ena),
      .amount(amount),
      .data(data),
      .q(q)
   );

   initial begin
      clk = 0;
      load = 0;
      ena = 0;
      amount = 0;
      data = 0;
      #5 load = 1;
      #5 ena = 1;
      #5 amount = 0;
      #5 load = 0;
      #10 ena = 0;
      #5 amount = 1;
      #5 ena = 1;
      #5 load = 1;
      #5 amount = 2;
      #5 ena = 1;
      #5 load = 0;
      #10 amount = 3;
      #5 ena = 1;
      #5 load = 1;
      #5 amount = 0;
      #5 ena = 0;
      #10 $finish;
   end

   always #5 clk = ~clk;

endmodule

