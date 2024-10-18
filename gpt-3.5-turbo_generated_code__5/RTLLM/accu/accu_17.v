module accu (
    input clk, 
    input rst_n, 
    input [7:0] data_in, 
    input valid_in, 
    output reg valid_out, 
    output reg [9:0] data_out
);

reg [7:0] accumulator [3:0]; // 4 8-bit accumulators to store input data
reg [2:0] count; // Counter to keep track of number of input data received
reg [9:0] temp_data_out; // Temporary variable to calculate data_out

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
        valid_out <= 0;
        data_out <= 0;
        for (int i = 0; i < 4; i = i + 1) begin
            accumulator[i] <= 0;
        end
    end
    else begin
        if (valid_in) begin
            accumulator[count] <= data_in; // Store input data in accumulator
            count <= count + 1; // Increment count
            if (count == 3) begin // If 4 input data received
                temp_data_out = accumulator[0] + accumulator[1] + accumulator[2] + accumulator[3]; // Calculate output data
                valid_out <= 1; // Set valid_out to 1
                data_out <= temp_data_out; // Output data_out
                count <= 0; // Reset count
            end
            else begin
                valid_out <= 0; // Set valid_out to 0
            end
        end
    end
end

endmodule

