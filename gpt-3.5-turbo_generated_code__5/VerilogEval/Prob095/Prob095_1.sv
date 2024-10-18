
module TopModule (
  input clk,
  input reset,
  output shift_ena
);

  reg [2:0] counter; // Counter to keep track of the number of clock cycles

  always@(posedge clk) begin
    if (reset) begin
      counter <= 3'b111; // Reset the counter to a value of 7
      shift_ena <= 1'b1; // Assert shift_ena for 4 clock cycles
    end else if (counter > 3'b000) begin
      counter <= counter - 1; // Decrement the counter
      shift_ena <= 1'b1; // Continue asserting shift_ena
    end else begin
      shift_ena <= 1'b0; // Deassert shift_ena
    end
  end

endmodule