
module div_16bit (
  input [15:0] A, // 16-bit dividend
  input [7:0] B, // 8-bit divisor
  output reg [15:0] result, // 16-bit quotient
  output reg [15:0] odd // 16-bit remainder
);

  reg [15:0] a_reg; // Register to hold the dividend
  reg [7:0] b_reg; // Register to hold the divisor
  reg [7:0] difference; // Difference between dividend and divisor
  reg [15:0] remainder_bits; // Bits used for calculating the remainder

  always @* begin
    a_reg = A; // Update a_reg with the value of A
    b_reg = B; // Update b_reg with the value of B
  end

  always @* begin
    result = 0; // Initialize the quotient to zero
    remainder_bits = {16{1'b0}}; // Initialize the remainder bits with zeros

    for (int i=15; i>=8; i=i-1) begin
      difference = a_reg[i-1:0] - {1'b0, b_reg}; // Calculate the difference between dividend and divisor

      if (difference >= 0) begin
        result[i] = 1; // Set the quotient bit to 1 if dividend bits are greater
        a_reg = difference; // Update the dividend with the difference
      end
    end

    remainder_bits = {a_reg[7:0], remainder_bits[15:1]}; // Concatenate the remainder bits with the highest remaining 1-bit of the dividend
    odd = remainder_bits; // Assign the remainder bits to the odd output port
  end

endmodule