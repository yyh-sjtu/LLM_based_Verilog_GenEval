module TopModule (
  input clk,
  input [7:0] in,
  input [7:0] anyedge,
  output [7:0] out
);

reg [7:0] previous_data;

// Register to hold the previous input value
always @(posedge clk) begin
  previous_data <= in;
end

// Detect any edge for each bit in the input vector
always @* begin
  for (integer i = 0; i < 8; i=i+1) begin
    if (anyedge[i] && (in[i] != previous_data[i]))
      out[i] <= 1;
    else 
      out[i] <= 0;
  end
end

endmodule

