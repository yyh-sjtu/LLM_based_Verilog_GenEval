
module TopModule (
  input  clk,
  input  load,
  input  [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q;
  reg [3:0] neighbor_count;
  integer i, j;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          neighbor_count = q[((i + 15) % 16) * 16 + ((j + 15) % 16)] +  // Top left
                           q[((i + 15) % 16) * 16 + j] +                 // Top
                           q[((i + 15) % 16) * 16 + ((j + 1) % 16)] +   // Top right
                           q[i * 16 + ((j + 15) % 16)] +                 // Left
                           q[i * 16 + ((j + 1) % 16)] +                   // Right
                           q[((i + 1) % 16) * 16 + ((j + 15) % 16)] +   // Bottom left
                           q[((i + 1) % 16) * 16 + j] +                   // Bottom
                           q[((i + 1) % 16) * 16 + ((j + 1) % 16)];    // Bottom right

          if (neighbor_count == 0 || neighbor_count == 1 || neighbor_count >= 4) begin
            next_q[i * 16 + j] <= 0;
          end else if (neighbor_count == 3) begin
            next_q[i * 16 + j] <= 1;
          end else begin
            next_q[i * 16 + j] <= q[i * 16 + j];
          end
        end
      end

      q <= next_q;
    end
  end

endmodule