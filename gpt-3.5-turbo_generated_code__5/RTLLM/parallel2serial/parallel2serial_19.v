
module parallel2serial(
  input wire clk,      // Clock signal
  input wire rst_n,    // Reset signal
  input wire [3:0] d,  // 4-bit parallel data input
  
  output wire valid_out,  // Valid signal
  output wire dout        // Serial output
);

  reg [3:0] data;    // Data register
  reg [1:0] cnt;     // Counter register
  
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      // Reset state
      cnt <= 2'b00;
      data <= 4'b0000;
      valid_out <= 0;
      dout <= 1'b0;
    end
    else begin
      // Counter increment
      if (cnt == 2'b11)
        cnt <= 2'b00;
      else
        cnt <= cnt + 1;
      
      // Data shifting
      data <= {data[2:0], d[3]};
      
      // Valid signal
      if (cnt == 2'b11)
        valid_out <= 1;
      else
        valid_out <= 0;
      
      // Serial output
      dout <= data[3];
    end
  end
  
endmodule