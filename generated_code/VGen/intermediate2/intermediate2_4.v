module counter( 
input clk,
input reset,
output reg [3:0] q
);

reg [3:0] count;

always @(posedge clk) begin
    if(reset) begin
        count <= 4'b0001;
    end else if(count == 4'b1100) begin
        count <= 4'b0001;
    end else begin
        count <= count + 4'b0001;
    end
end

assign q = count;

endmodule

