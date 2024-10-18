
module TopModule(
  input  wire clk,
  input  wire load,
  input  wire [255:0] data,
  output wire [255:0] q
);

  reg [255:0] q_next;

  // Initial state loading
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end
  end

  // Game state updating
  always @(posedge clk) begin
    // Compute next state for each cell
    for (int i = 0; i < 16; i = i + 1) begin
      for (int j = 0; j < 16; j = j + 1) begin
        int num_neighbours = 0;

        // Count the number of alive neighbours
        num_neighbours = num_neighbours + q[(i-1)*16 + j-1];
        num_neighbours = num_neighbours + q[(i-1)*16 + j];
        num_neighbours = num_neighbours + q[(i-1)*16 + (j+1)];
        num_neighbours = num_neighbours + q[(i)*16 + j-1];
        num_neighbours = num_neighbours + q[(i)*16 + (j+1)];
        num_neighbours = num_neighbours + q[(i+1)*16 + j-1];
        num_neighbours = num_neighbours + q[(i+1)*16 + j];
        num_neighbours = num_neighbours + q[(i+1)*16 + (j+1)];

        // Update cell state based on neighbour count
        if (num_neighbours <= 1) begin
          q_next[i*16 + j] = 0;
        end else if (num_neighbours == 2) begin
          q_next[i*16 + j] = q[i*16 + j];
        end else if (num_neighbours == 3) begin
          q_next[i*16 + j] = 1;
        end else begin
          q_next[i*16 + j] = 0;
        end
      end
    end

    // Update current state with next state
    q <= q_next;
  end

endmodule