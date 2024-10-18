module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (integer i = 0; i < 512; i = i + 1) begin
        if (i == 0) begin
          // Boundary condition: q[-1] = 0
          if ((q[0] == 1) && (q[1] == 1))
            q[0] <= 0;
          else if ((q[0] == 1) && (q[1] == 0))
            q[0] <= 1;
          else if ((q[0] == 0) && (q[1] == 1))
            q[0] <= 1;
          else if ((q[0] == 0) && (q[1] == 0))
            q[0] <= 0;
        end else if (i == 511) begin
          // Boundary condition: q[512] = 0
          if ((q[510] == 1) && (q[511] == 1))
            q[511] <= 0;
          else if ((q[510] == 1) && (q[511] == 0))
            q[511] <= 1;
          else if ((q[510] == 0) && (q[511] == 1))
            q[511] <= 1;
          else if ((q[510] == 0) && (q[511] == 0))
            q[511] <= 0;
        end else begin
          // Apply Rule 110 to the rest of the cells
          if ((q[i-1] == 1) && (q[i] == 1) && (q[i+1] == 1))
            q[i] <= 0;
          else if ((q[i-1] == 1) && (q[i] == 1) && (q[i+1] == 0))
            q[i] <= 1;
          else if ((q[i-1] == 1) && (q[i] == 0) && (q[i+1] == 1))
            q[i] <= 1;
          else if ((q[i-1] == 1) && (q[i] == 0) && (q[i+1] == 0))
            q[i] <= 0;
          else if ((q[i-1] == 0) && (q[i] == 1) && (q[i+1] == 1))
            q[i] <= 1;
          else if ((q[i-1] == 0) && (q[i] == 1) && (q[i+1] == 0))
            q[i] <= 1;
          else if ((q[i-1] == 0) && (q[i] == 0) && (q[i+1] == 1))
            q[i] <= 1;
          else if ((q[i-1] == 0) && (q[i] == 0) && (q[i+1] == 0))
            q[i] <= 0;
        end
      end
    end
  end
  
endmodule

