
module left_rotate (
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

reg [7:0] shifted_data;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shifted_data <= 8'b0;
    end else if (load) begin
        shifted_data <= data;
    end else begin
        shifted_data <= {data[amount-1:0], data[7:amount]};
    end
end

assign out = shifted_data;

endmodule