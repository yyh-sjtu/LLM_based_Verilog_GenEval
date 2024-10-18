
module TopModule(
  input clk,
  input load,
  input [511:0] data,
  output [511:0] q
);

  reg [511:0] q_reg;
  reg [511:0] q_next;
  
  always @(posedge clk) begin
    if (load) begin
      q_reg <= data;
    end else begin
      q_reg <= q_next;
    end
  end
  
  genvar i;
  generate
    for(i=0; i<512; i=i+1) begin
      always @(*) begin
        if (i == 0) begin
          q_next[i] = (q_reg[0] & q_reg[1]);
        end else if (i == 511) begin
          q_next[i] = (q_reg[510] & q_reg[511]);
        end else begin
          q_next[i] = (q_reg[i-1] & q_reg[i] & ~q_reg[i+1]) |
                      (q_reg[i-1] & ~q_reg[i] & q_reg[i+1]) |
                      (q_reg[i-1] & ~q_reg[i] & ~q_reg[i+1]) |
                      (~q_reg[i-1] & q_reg[i] & q_reg[i+1]);
        end
      end
    end
  endgenerate

  assign q = q_reg;

endmodule