
module top_module(
    input clk,
    input reset,
    output reg [9:0] q
);

reg [9:0] count;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        count <= 10'b0;
    end else begin
        if(count == 10'd999) begin
            count <= 10'b0;
        end else begin
            count <= count + 1;
        end
    end
end

assign q = count;

endmodule