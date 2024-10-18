module rotator(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else if ((ena == 2'b01) || (ena == 2'b10)) begin
      if (ena == 2'b01) begin
        q <= {q[0], q[99:1]};
      end else begin
        q <= {q[1:99], q[0]};
      end
    end
  end

endmodule

module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  rotator rotator1(
    .clk(clk),
    .load(load),
    .ena(ena),
    .data(data),
    .q(q)
  );

endmodule

