
module left_rotate(
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

reg [7:0] shifted_data;

always @(posedge clk) begin
    if(reset) begin
        shifted_data <= '0;
        out <= '0;
    end
    else begin
        if(load) begin
            shifted_data <= data;
        end
        else begin
            shifted_data <= {shifted_data[7 - amount:0], shifted_data[7:8 - amount]};
        end
        out <= shifted_data;
    end
end

endmodule