
module BCDCounter (
    input clk,
    input reset,
    output reg [3:0] ones_digit,
    output reg [3:0] tens_digit,
    output reg [3:0] hundreds_digit,
    output reg [3:0] thousands_digit,
    output reg [3:0] ena,
    output reg [15:0] q
);

reg [15:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 16'b0;
    end else begin
        count <= count + 1;
    end
end

always @* begin
    ones_digit   = count[3:0];
    tens_digit   = count[7:4];
    hundreds_digit = count[11:8];
    thousands_digit = count[15:12];

    ena[0] = (ones_digit == 4'b9);
    ena[1] = (tens_digit == 4'b9) && (ena[0]);
    ena[2] = (hundreds_digit == 4'b9) && (ena[0]) && (ena[1]);
    ena[3] = (thousands_digit == 4'b9) && (ena[0]) && (ena[1]) && (ena[2]);

    q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
end

endmodule