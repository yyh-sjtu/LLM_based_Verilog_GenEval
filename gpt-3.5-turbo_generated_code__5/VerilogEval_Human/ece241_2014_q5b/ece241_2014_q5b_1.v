module top_module (
   input clk,
   input areset,
   input x,
   output z
);

   reg [1:0] state;
   wire next_state_a, next_state_b;

   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= 2'b00;
      end else begin
         state <= next_state_a ? 2'b00 :
                  next_state_b ? 2'b01 :
                  state;
      end
   end

   assign next_state_a = (!x);
   assign next_state_b = x;

   assign z = (state == 2'b01);

endmodule

