
module TopModule(
  input   clk,
  input   reset,
  output  reg [3:0] q
);

// Internal signal declaration
reg [3:0] count;

always @(posedge clk) begin
  if (reset) begin
    // Reset counter to 1
    count <= 4'b0001;
  end else begin
    // Increment counter
    if (count == 4'b1010) begin
      count <= 4'b0001;
    end else begin
      count <= count + 1;
    end
  end
end

// Assign output
assign q = count;

endmodule