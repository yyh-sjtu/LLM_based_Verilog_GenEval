
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  wire [3:0] mux_out;

  always @* begin
    case (sel)
      0: mux_out = in[3:0];
      1: mux_out = in[7:4];
      2: mux_out = in[11:8];
      // Add more cases for other sel values
      // ...
      default: mux_out = 4'h0; // Default case
    endcase
  end

  assign out = mux_out;

endmodule