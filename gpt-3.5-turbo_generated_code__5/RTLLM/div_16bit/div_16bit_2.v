module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output reg [15:0] result,
    output reg [15:0] odd
);

reg [15:0] a_reg;
reg [7:0] b_reg;

always @ (A, B)
begin
    a_reg <= A;
    b_reg <= B;
end

always @ (A, B)
begin
    reg [15:0] rem;
    reg [3:0] i;

    if (B == 0)
    begin
        result <= 16'b0;
        odd <= 16'b0;
    end
    else if (B == 1)
    begin
        result <= A;
        odd <= 16'b0;
    end
    else
    begin
        rem = a_reg;
        result = 16'b0;

        for (i = 15; i >= 8; i = i - 1)
        begin
            if (rem[i] == 1)
            begin
                result[i:8] <= 8'b1;
                rem = rem - (b_reg << (i-8));
            end
        end

        odd = {rem[i-1], rem[i-2], rem[i-3], rem[i-4], rem[i-5], rem[i-6], rem[i-7], rem[6:0]};
    end
end

endmodule

