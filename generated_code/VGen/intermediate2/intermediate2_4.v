
module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
    
    assign {cout, sum} = a + b + cin;
    
endmodule
module counter(
    input wire clk,
    input wire reset,
    output reg [3:0] q
);

reg [15:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000;
        q <= count[3:0];
    end else begin
        count <= count + 1;
        q <= count[3:0];
    end
end

endmodule