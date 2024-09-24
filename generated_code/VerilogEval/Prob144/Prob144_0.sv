
module TopModule(
    input wire clk,
    input wire load,
    input wire [255:0] data,
    output reg [255:0] q
);

    // Internal variables to hold the next state
    reg [255:0] next_q;

    // Function to count the live neighbours for a given cell
    function integer count_neighbours(
        input [255:0] grid,
        input integer x,
        input integer y
    );
        integer count;
        integer i, j;
        
        // Initialize count to 0
        count = 0;

        // Check all 8 possible neighbours including wrap-around
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i == 0 && j == 0) continue; // Skip the cell itself

                // Calculate wrapped indices
                integer nx = (x + i + 16) % 16; // Wrap around in x direction
                integer ny = (y + j + 16) % 16; // Wrap around in y direction
                count = count + grid[nx + ny * 16]; // Access the grid
            end
        end

        count_neighbours = count;
    endfunction

    // Sequential logic
    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load data into q at next clock edge
        end else begin
            // Update the next_q based on the current q
            for (integer row = 0; row < 16; row = row + 1) begin
                for (integer col = 0; col < 16; col = col + 1) begin
                    integer idx = col + row * 16;
                    integer neighbour_count = count_neighbours(q, col, row);

                    // Apply the rules to determine the next state
                    if (q[idx] == 1'b1) begin // Cell is alive
                        if (neighbour_count < 2 || neighbour_count > 3) begin
                            next_q[idx] = 1'b0; // Cell dies
                        end else begin
                            next_q[idx] = 1'b1; // Cell stays alive
                        end
                    end else begin // Cell is dead
                        if (neighbour_count == 3) begin
                            next_q[idx] = 1'b1; // Cell becomes alive
                        end else begin
                            next_q[idx] = 1'b0; // Cell stays dead
                        end
                    end
                end
            end
            
            // Update the current state to the next state
            q <= next_q;
        end
    end

endmodule