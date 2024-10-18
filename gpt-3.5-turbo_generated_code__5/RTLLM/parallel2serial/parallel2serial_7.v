
module parallel2serial (
    input wire clk,
    input wire rst_n,
    input wire [3:0] d,
    output reg valid_out,
    output reg dout
);

reg [3:0] data; // Register to hold the parallel input
reg [1:0] cnt; // Counter to track the current bit being output

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        data <= 4'b0;
        cnt <= 2'b0;
        valid_out <= 1'b0;
        dout <= 1'b0;
    end
    else begin
        if (cnt == 2'b11) begin // Last bit of the parallel input
            data <= d; // Update data with the parallel input
            cnt <= 2'b0; // Reset counter
            valid_out <= 1'b1; // Set valid signal to 1
        end
        else begin // Shift and output next bit
            cnt <= cnt + 1; // Increment counter
            valid_out <= 1'b0; // Set valid signal to 0
            data <= {data[2:0], data[3]}; // Shift data by 1 bit to the left
        end
    end
end

assign dout = data[3]; // Output the most significant bit of the data register

endmodule