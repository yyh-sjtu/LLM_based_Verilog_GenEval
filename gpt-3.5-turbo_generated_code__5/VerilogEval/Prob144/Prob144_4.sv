
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q; // Next state of q

  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      // Update game state
      for (int i = 0; i < 256; i = i + 1) begin
        int row = i/16; // Row number of the current cell
        int col = i%16; // Column number of the current cell

        // Count the number of alive neighbors
        int neighbors = 0;

        // Check all the neighbors of the current cell
        if (q[((row-1+16)%16)*16 + ((col-1+16)%16)] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[((row-1+16)%16)*16 + col] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[((row-1+16)%16)*16 + ((col+1)%16)] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[row*16 + ((col-1+16)%16)] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[row*16 + ((col+1)%16)] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[((row+1)%16)*16 + ((col-1+16)%16)] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[((row+1)%16)*16 + col] == 1) begin
          neighbors = neighbors + 1;
        end
        if (q[((row+1)%16)*16 + ((col+1)%16)] == 1) begin
          neighbors = neighbors + 1;
        end

        // Update cell state based on the number of neighbors
        if (neighbors == 3) begin
          next_q[i] = 1;
        end else if (neighbors == 2) begin
          next_q[i] = q[i];
        end else begin
          next_q[i] = 0;
        end
      end

      q <= next_q; // Update current state
    end
  end

endmodule