
module accu(
    input clk, // Clock input for synchronization
    input rst_n, // Active-low reset signal
    input [7:0] data_in, // 8-bit input data for addition
    input valid_in, // Input signal indicating readiness for new data
    output reg valid_out, // Output signal indicating when 4 input data accumulation is reached
    output reg [9:0] data_out // 10-bit output data representing the accumulated sum
);

reg [1:0] count; // Counter to keep track of number of input data received
reg [31:0] sum; // Sum accumulator for the input data

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        count <= 2'b00; // Reset counter to 0
        sum <= 32'b0; // Reset sum accumulator to 0
        valid_out <= 1'b0; // Reset valid_out to 0
        data_out <= 10'b0; // Reset data_out to 0
    end else begin
        if (valid_in) begin
            // Accumulate the input data
            sum <= sum + data_in;
            count <= count + 1;
            
            if (count == 2'b11) begin
                // When 4 input data received, update the data_out and set valid_out = 1
                data_out <= sum;
                valid_out <= 1'b1;
            end else begin
                valid_out <= 1'b0;
            end
        end
    end
end

endmodule