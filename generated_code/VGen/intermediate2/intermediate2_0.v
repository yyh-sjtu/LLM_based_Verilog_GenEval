
module full_adder (
    input a,
    input b,
    input cin,
    output reg sum,
    output reg cout
);

always @(*) begin
    sum = a ^ b ^ cin;
    cout = (a & b) | (b & cin) | (a & cin);
end

endmodule
module counter( 
    input clk,
    input reset,
    output reg [3:0] q
);

reg [15:0] count;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0001;
        q <= 4'b0001;
    end else begin
        if (count < 4'b1100) begin
            count <= count + 1;
        end else begin
            count <= 4'b0001;
        end
        q <= count[3:0];
    end
end

endmodule