module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

typedef enum logic [2:0] {
  S_000,
  S_001,
  S_010,
  S_011,
  S_100
} state_t;

reg [2:0] y, next_y;

always @(posedge clk) begin
  if (reset) begin
    y <= S_000;
    z <= 0;
  end else begin
    y <= next_y;
    case(y)
      S_000:
        if (x) next_y = S_001;
        else next_y = S_000;
      S_001:
        if (x) next_y = S_100;
        else next_y = S_001;
      S_010:
        if (x) next_y = S_001;
        else next_y = S_010;
      S_011:
        next_y = S_010;
        z <= 1;
      S_100:
        if (x) next_y = S_100;
        else next_y = S_011;
      default:
        next_y = S_000;
    endcase
  end
end

endmodule

