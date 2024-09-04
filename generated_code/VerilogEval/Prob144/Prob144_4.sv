
module TopModule(
    input wire clk,
    input wire load,
    input wire [255:0] data,
    output reg [255:0] q
);

// Define the neighbor offset positions
localparam integer NEIGHBOR_OFFSETS[0:7][0:1] = '{
    { 1,  0}, // Right
    { 0,  1}, // Down
    {-1,  0}, // Left
    { 0, -1}, // Up
    { 1,  1}, // Down-Right
    {-1,  1}, // Down-Left
    { 1, -1}, // Up-Right
    {-1, -1}  // Up-Left
};

// Function to wrap coordinates for the toroidal grid
function [3:0] wrap_coord(input [3:0] coord);
    wrap_coord = coord[3:0]; // Keeps it as is
    if (coord < 0) wrap_coord = coord + 16;
    if (coord >= 16) wrap_coord = coord - 16;
endfunction

// Compute the next state of the grid
function [255:0] compute_next_state(input [255:0] current_state);
    integer i, j;
    reg [3:0] alive_neighbors;
    reg [255:0] new_state = 0;

    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            alive_neighbors = 0;

            // Check all 8 neighbors
            for (k = 0; k < 8; k = k + 1) begin
                int ni = wrap_coord(i + NEIGHBOR_OFFSETS[k][0]);
                int nj = wrap_coord(j + NEIGHBOR_OFFSETS[k][1]);
                alive_neighbors = alive_neighbors + current_state[ni * 16 + nj];
            end
            
            // Update the new state based on alive_neighbors
            case (current_state[i * 16 + j])
                1'b1: // Cell is alive
                    new_state[i * 16 + j] = (alive_neighbors == 2) ? 1'b1 : (alive_neighbors == 3) ? 1'b1 : 1'b0;
                1'b0: // Cell is dead
                    new_state[i * 16 + j] = (alive_neighbors == 3) ? 1'b1 : 1'b0;
            endcase
        end
    end
    compute_next_state = new_state;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data; // Load the initial state
    end else begin
        q <= compute_next_state(q); // Advance the game state
    end
end

endmodule