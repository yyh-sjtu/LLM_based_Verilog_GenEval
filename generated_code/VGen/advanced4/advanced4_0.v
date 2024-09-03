module advshift(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

  reg [63:0] temp;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      if (ena) begin
        case(amount)
          2'b00: temp <= q << 1; // shift left by 1 bit
          2'b01: temp <= q << 8; // shift left by 8 bits
          2'b10: temp <= q >> 1; // shift right by 1 bit
          2'b11: temp <= q >> 8; // shift right by 8 bits
          default: temp <= q;
        endcase
        q <= temp;
      end
    end
  end

endmodule

