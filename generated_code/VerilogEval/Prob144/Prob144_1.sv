
module TopModule (
    input wire clk,
    input wire load,
    input wire [255:0] data,
    output reg [255:0] q
);

    // Function to count the neighbors of a cell
    function [3:0] count_neighbors(input [255:0] state, input integer row, input integer col);
        integer rr, cc;
        integer count;
        begin
            count = 0;

            // Iterate over the 3x3 area around the cell (wrapping around for toroidal effect)
            for (rr = -1; rr <= 1; rr = rr + 1) begin
                for (cc = -1; cc <= 1; cc = cc + 1) begin
                    if (rr == 0 && cc == 0) 
                        continue; // Skip the cell itself

                    // Calculate wrapped indices
                    integer wrapped_row = (row + rr + 16) % 16;
                    integer wrapped_col = (col + cc + 16) % 16;

                    // Increment count if it is alive (1)
                    count = count + state[wrapped_row * 16 + wrapped_col][0];
                end
            end
            
            count_neighbors = count;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            // Load initial state
            q <= data;
        end else begin
            reg [255:0] new_q;
            integer r, c;
            
            // Compute new state
            for (r = 0; r < 16; r = r + 1) begin
                for (c = 0; c < 16; c = c + 1) begin
                    // Count neighbors
                    integer alive_neighbors = count_neighbors(q, r, c);
                    // Update state based on the rules
                    case (alive_neighbors)
                        0, 1: new_q[r * 16 + c] = 0; // Cell becomes dead
                        2: new_q[r * 16 + c] = q[r * 16 + c]; // Cell state remains the same
                        3: new_q[r * 16 + c] = 1; // Cell becomes alive
                        default: new_q[r * 16 + c] = 0; // 4+ neighbors => Cell becomes dead
                    endcase
                end
            end

            // Update q with the new state
            q <= new_q;
        end
    end

endmodule