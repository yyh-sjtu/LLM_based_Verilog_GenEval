
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output reg q
);

  always @* begin
    if (a == 0 && b == 0 && c == 0 && d == 0)  // 20ns
      q = 0;
    else if (a == 0 && b == 0 && c == 0 && d == 1)  // 40ns
      q = 1;
    else if (a == 0 && b == 0 && c == 1 && d == 0)  // 70ns
      q = 1;
    else if (a == 0 && b == 0 && c == 1 && d == 1)  // 50ns
      q = 1;
    else if (a == 0 && b == 1 && c == 0 && d == 0)  // 35ns
      q = 0;
    else if (a == 0 && b == 1 && c == 0 && d == 1)  // 45ns
      q = 1;
    else if (a == 0 && b == 1 && c == 1 && d == 0)  // 45ns
      q = 1;
    else if (a == 0 && b == 1 && c == 1 && d == 1)  // 50ns
      q = 1;
    else if (a == 1 && b == 0 && c == 0 && d == 0)  // 55ns
      q = 0;
    else if (a == 1 && b == 0 && c == 0 && d == 1)  // 60ns
      q = 1;
    else if (a == 1 && b == 0 && c == 1 && d == 0)  // 65ns
      q = 1;
    else if (a == 1 && b == 0 && c == 1 && d == 1)  // 70ns
      q = 1;
    else if (a == 1 && b == 1 && c == 0 && d == 0)  // 75ns
      q = 0;
    else if (a == 1 && b == 1 && c == 0 && d == 1)  // 80ns
      q = 1;
    else if (a == 1 && b == 1 && c == 1 && d == 0)  // 85ns
      q = 1;
    else if (a == 1 && b == 1 && c == 1 && d == 1)  // 90ns
      q = 1;
    else
      q = 0;
  end

endmodule