module multi_pipe_4bit(
  input clk,
  input rst_n,
  input [3:0] mul_a,
  input [3:0] mul_b,
  output reg [7:0] mul_out
);

parameter size = 4;

always @ (posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    mul_out <= 8'b0;
  end
  else begin
    genvar i;
    generate
      for(i = 0; i < size; i = i + 1) begin: bit_mult
        reg [7:0] partial_prod;

        always @ (*) begin
          if(mul_b[i] == 1'b1)
            partial_prod = {mul_a, {8{i{1'b0}}}};
          else
            partial_prod = 8'b0;
        end
        
        always @ (posedge clk or negedge rst_n) begin
          if(~rst_n)
            partial_prod <= 8'b0;
          else
            mul_out <= mul_out + partial_prod;
        end
      end
    endgenerate
  end
end

endmodule

