
module TopModule(
  input  wire clk,
  input  wire load,
  input  wire [9:0] data,
  output wire tc
);

  reg [9:0] counter;
  reg tc_reg;
  reg load_reg;

  always @(posedge clk) begin
    if (load_reg) begin
      counter <= data;
    end else if (counter == 0) begin
      tc_reg <= 1;
    end else begin
      counter <= counter - 1;
      tc_reg <= 0;
    end
  end

  always @(posedge clk) begin
    load_reg <= load;
  end

  assign tc = tc_reg;

endmodule