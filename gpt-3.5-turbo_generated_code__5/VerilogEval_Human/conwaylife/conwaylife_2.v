module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Define the internal signals
reg [255:0] next_state;
reg [7:0] neighbors;
integer i, j;

// Always block for clock edge detection
always @(posedge clk) begin
    if (load) begin
        // Load initial state from data input
        q <= data;
    end else begin
        // Update game state
        for (i = 0; i < 256; i = i + 16) begin
            for (j = 0; j < 16; j = j + 1) begin
                // Calculate the number of neighbors for each cell
                neighbors = q[i + ((j + 15) % 16)] + q[i + ((j + 1) % 16)] + q[i + (j % 16)] +
                            q[((i + 16) % 256) + ((j + 1) % 16)] + q[((i + 16) % 256) + (j % 16)] +
                            q[((i + 16) % 256) + ((j + 15) % 16)] + q[((i - 16) % 256) + ((j + 1) % 16)] +
                            q[((i - 16) % 256) + (j % 16)] + q[((i - 16) % 256) + ((j + 15) % 16)];

                // Update cell state based on the number of neighbors
                if (neighbors <= 1) begin
                    next_state[i + j] = 0;
                end else if (neighbors == 2) begin
                    next_state[i + j] = q[i + j];
                end else if (neighbors == 3) begin
                    next_state[i + j] = 1;
                end else begin
                    next_state[i + j] = 0;
                end
            end
        end
        q <= next_state; // Update q with the next state
    end
end

endmodule

