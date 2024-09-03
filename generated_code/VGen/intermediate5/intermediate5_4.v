module left_rotate(
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

// Register to store shifted value
reg [7:0] shifted_data;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shifted_data <= 8'b0;
        out <= 8'b0;
    end else begin
        if (load) begin
            shifted_data <= data << amount;
        end else begin
            shifted_data <= {shifted_data[6:0], shifted_data[7]};
        end
    end
end

assign out = shifted_data;

endmodule

