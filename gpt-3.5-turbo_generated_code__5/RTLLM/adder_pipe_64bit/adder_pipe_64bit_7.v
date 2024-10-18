
module adder_pipe_64bit (
  input clk, 
  input rst_n, 
  input i_en, 
  input [63:0] adda, 
  input [63:0] addb, 
  output reg [64:0] result, 
  output reg o_en
);

  reg [63:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6;
  reg [6:0] carry0, carry1, carry2, carry3, carry4, carry5, carry6;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      sum0 <= 0;
      sum1 <= 0;
      sum2 <= 0;
      sum3 <= 0;
      sum4 <= 0;
      sum5 <= 0;
      sum6 <= 0;
      carry0 <= 0;
      carry1 <= 0;
      carry2 <= 0;
      carry3 <= 0;
      carry4 <= 0;
      carry5 <= 0;
      carry6 <= 0;
      o_en <= 0;
      result <= 0;
    end else begin
      if (i_en) begin
        sum0 <= adda[0] + addb[0];
        carry0 <= sum0[1];
        
        sum1 <= adda[1] + addb[1] + carry0;
        carry1 <= sum1[1];
        
        sum2 <= adda[2] + addb[2] + carry1;
        carry2 <= sum2[1];
        
        sum3 <= adda[3] + addb[3] + carry2;
        carry3 <= sum3[1];
        
        sum4 <= adda[4] + addb[4] + carry3;
        carry4 <= sum4[1];
        
        sum5 <= adda[5] + addb[5] + carry4;
        carry5 <= sum5[1];
        
        sum6 <= adda[6] + addb[6] + carry5;
        carry6 <= sum6[1];
        
        o_en <= 1;
        result <= {carry6, sum6, sum5, sum4, sum3, sum2, sum1, sum0};
        
      end else begin
        o_en <= 0;
        result <= 0;
      end
    end
  end
endmodule