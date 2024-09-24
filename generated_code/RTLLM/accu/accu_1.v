
module accu(
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] data_accum[3:0]; // Array to store 4 input data values for accumulation
reg [2:0] count; // Counter to keep track of number of valid input data values

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        valid_out <= 0;
        data_out <= 10'b0;
        count <= 0;
        data_accum <= {8'b0, 8'b0, 8'b0, 8'b0};
    end
    else if (valid_in) begin
        data_accum[count] <= data_in; // Store input data to array
        count <= count + 1; // Increment counter
        if (count == 3) begin
            data_out <= data_accum[0] + data_accum[1] + data_accum[2] + data_accum[3]; // Calculate sum
            valid_out <= 1; // Set valid_out signal to 1
        end
        else begin
            valid_out <= 0;
            data_out <= 10'b0;
        end
    end
    else begin
        valid_out <= 0;
        data_out <= 10'b0;
        count <= 0;
        data_accum <= {8'b0, 8'b0, 8'b0, 8'b0};
    end
end

endmodule