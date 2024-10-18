module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output out
);

reg out;

always @(*) begin
  case (sel)
    0: out = in[0];
    1: out = in[1];
    2: out = in[2];
    // ... Continue cases for sel=3 to sel=255
    default: out = 1'b0; // Default case when sel > 255
  endcase
end

endmodule

