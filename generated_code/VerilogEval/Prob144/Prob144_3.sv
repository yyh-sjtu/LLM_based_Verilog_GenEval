
module TopModule (
    input       clk,
    input       load,
    input [255:0] data,
    output reg [255:0] q
);

// Internal registers to hold the next state and current state
reg [255:0] next_q;

// Function to count the alive neighbors for a given cell
function [3:0] count_neighbors;
    input [255:0] grid;
    input [3:0] x; // x coordinate
    input [3:0] y; // y coordinate
    integer i, j;
    begin
        count_neighbors = 0;
        // Check all 8 possible neighbors
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i == 0 && j == 0) continue; // Skip the cell itself
                // Calculate wrapped coordinates
                integer nx = (x + i + 16) % 16; // Wrap around for x
                integer ny = (y + j + 16) % 16; // Wrap around for y
                // Count if neighbor is alive (1)
                count_neighbors = count_neighbors + grid[nx*16 + ny];
            end
        end
    end
endfunction

// Sequential logic to update the grid
always @(posedge clk) begin
    if (load) begin
        q <= data; // Load data on load signal
    end else begin
        // Calculate the next state
        integer x, y;
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                integer alive_neighbors = count_neighbors(q, x, y);
                // Apply the game rules
                if (q[x*16 + y] == 1) begin
                    // Cell is currently alive
                    if (alive_neighbors == 2 || alive_neighbors == 3) begin
                        next_q[x*16 + y] = 1; // Remain alive
                    end else begin
                        next_q[x*16 + y] = 0; // Dies
                    end
                end else begin
                    // Cell is currently dead
                    if (alive_neighbors == 3) begin
                        next_q[x*16 + y] = 1; // Becomes alive
                    end else begin
                        next_q[x*16 + y] = 0; // Remains dead
                    end
                end
            end
        end
        q <= next_q; // Update the current state
    end
end

endmodule