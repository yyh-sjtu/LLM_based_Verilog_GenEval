module game_of_life(
    input clk,     // Clock input
    input load,    // Load input for loading initial state
    input [255:0] data,  // Data input for initial state
    output reg [255:0] q // Output representing the current state of the game
);

// Define registers for storing the current and next state of the game
reg [255:0] current_state, next_state;

// Define parameters for grid size
parameter ROW_SIZE = 16;
parameter GRID_SIZE = 256;

// Define internal signals for row and column index
reg [3:0] row_idx, col_idx;

always @ (posedge clk) begin
    // If load signal is high, load initial state data into current state
    if (load) begin
        current_state <= data;
    end
    
    // Calculate the next state of the game based on current state
    for (row_idx = 0; row_idx < ROW_SIZE; row_idx = row_idx + 1) begin
        for (col_idx = 0; col_idx < ROW_SIZE; col_idx = col_idx + 1) begin
            // Calculate number of neighbors for current cell
            // Left, right, up and down neighbors
            reg [7:0] neighbor_count;
            neighbor_count = current_state[((row_idx + 1) % ROW_SIZE) * ROW_SIZE + col_idx] + 
                             current_state[((row_idx - 1 + ROW_SIZE) % ROW_SIZE) * ROW_SIZE + col_idx] + 
                             current_state[row_idx * ROW_SIZE + ((col_idx + 1) % ROW_SIZE)] + 
                             current_state[row_idx * ROW_SIZE + ((col_idx - 1 + ROW_SIZE) % ROW_SIZE)] + 
                             // Diagonal neighbors
                             current_state[((row_idx + 1) % ROW_SIZE) * ROW_SIZE + ((col_idx + 1) % ROW_SIZE)] + 
                             current_state[((row_idx + 1) % ROW_SIZE) * ROW_SIZE + ((col_idx - 1 + ROW_SIZE) % ROW_SIZE)] + 
                             current_state[((row_idx - 1 + ROW_SIZE) % ROW_SIZE) * ROW_SIZE + ((col_idx + 1) % ROW_SIZE)] + 
                             current_state[((row_idx - 1 + ROW_SIZE) % ROW_SIZE) * ROW_SIZE + ((col_idx - 1 + ROW_SIZE) % ROW_SIZE)];
            
            // Update cell state based on number of neighbors
            if (neighbor_count == 0 || neighbor_count >= 4) begin
                next_state[row_idx * ROW_SIZE + col_idx] = 0; // Cell becomes 0
            end else if (neighbor_count == 3) begin
                next_state[row_idx * ROW_SIZE + col_idx] = 1; // Cell becomes 1
            end else begin
                next_state[row_idx * ROW_SIZE + col_idx] = current_state[row_idx * ROW_SIZE + col_idx]; // Cell state does not change
            end
        end
    end
    
    // Update current state to next state for the next clock cycle
    current_state <= next_state;
    q <= current_state;
end

endmodule

