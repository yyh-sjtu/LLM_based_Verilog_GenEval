module game_of_life(
  input [1:0] neighbors, // Number of neighbors that the cell has
  input cell_state, // Current state of the cell
  output reg next_state // Next state of the cell
);

  always @(*) begin
    case (neighbors)
      2: next_state = cell_state; // Cell state does not change
      3: next_state = 1; // Cell becomes alive
      default: next_state = 0; // Cell becomes dead
    endcase
  end

endmodule

module top_module(
  input clk, // Clock signal
  input load, // Load signal (synchronous)
  input [255:0] data, // Initial state of the game
  output reg [255:0] q // Current state of the game
);

  reg [255:0] q_next; // Next state of the game

  // Define the wires for the neighbors in each direction
  wire [1:0] north_neighbor, south_neighbor, west_neighbor, east_neighbor;
  wire [1:0] nw_neighbor, ne_neighbor, sw_neighbor, se_neighbor;

  // Define the wires for the number of neighbors
  wire [1:0] num_neighbors;

  // Connect the wires to the appropriate cells in the grid
  assign north_neighbor = {q[239:224], q[255]};
  assign south_neighbor = {q[15], q[0:15]};
  assign west_neighbor = {q[240:0]};
  assign east_neighbor = {q[255:16]};
  assign nw_neighbor = q[240];
  assign ne_neighbor = q[255];
  assign sw_neighbor = q[0];
  assign se_neighbor = q[15];

  // Connect the wires to the appropriate count of neighbors
  assign num_neighbors = north_neighbor + south_neighbor + west_neighbor + east_neighbor +
    nw_neighbor + ne_neighbor + sw_neighbor + se_neighbor;

  // Define the nested for loop to calculate the next state of each cell
  genvar i, j;
  generate
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Instantiate the game_of_life module for each cell
        game_of_life gol (
          .neighbors(num_neighbors[i*16 + j]),
          .cell_state(q[i*16 + j]),
          .next_state(q_next[i*16 + j])
        );
      end
    end
  endgenerate

  // Assign the next state to the current state on the positive edge of the clock
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load the initial state
    end else begin
      q <= q_next; // Update the current state
    end
  end

endmodule

