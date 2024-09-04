module left_rotate(
    input clk, 
    input reset, 
    input [2:0] amount, 
    input [7:0] data, 
    input load, 
    output reg [7:0] out 
);

reg [7:0] shifted_data;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        out <= 8'b0;
        shifted_data <= 8'b0;
    end else begin
        if(load) begin
            out <= data;
            shifted_data <= data;
        end else begin
            shifted_data <= {data[6:amount],data[7:7-amount]};
            out <= shifted_data;
        end
    end
end

endmodule

