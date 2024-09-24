
module TopModule (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Internal variable for the next state
reg [255:0] next_q;

// Function to count the number of alive neighbors
function [3:0] count_neighbors;
    input [255:0] grid;
    input integer row;
    input integer col;
    integer i, j;
    reg [3:0] count;
    begin
        count = 0;
        
        // Iterate over the neighboring positions
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i == 0 && j == 0) begin
                    continue; // Skip itself
                end
                
                // Calculate the neighbor's coordinates with wrap-around
                integer neighbor_row = (row + i + 16) % 16;
                integer neighbor_col = (col + j + 16) % 16;
                
                // Increment the count if the neighbor is alive
                count = count + grid[neighbor_row * 16 + neighbor_col];
            end
        end
        count_neighbors = count;
    end
endfunction

integer r, c;

always @(*) begin
    // Default next_q to the current state
    next_q = q;

    // Update the next state based on the current state
    for (r = 0; r < 16; r = r + 1) begin
        for (c = 0; c < 16; c = c + 1) begin
            // Count the neighbors of the current cell
            integer neighbors = count_neighbors(q, r, c);
            
            // Apply the game rules
            case (q[r * 16 + c])
                1'b0: begin // Dead cell
                    if (neighbors == 3) begin
                        next_q[r * 16 + c] = 1'b1; // Cell becomes alive
                    end
                end
                1'b1: begin // Alive cell
                    if (neighbors < 2 || neighbors > 3) begin
                        next_q[r * 16 + c] = 1'b0; // Cell dies
                    end
                end
            endcase
        end
    end
end

// Synchronous logic
always @(posedge clk) begin
    if (load) begin
        q <= data; // Load new data into q
    end else begin
        q <= next_q; // Advance the game state
    end
end

endmodule