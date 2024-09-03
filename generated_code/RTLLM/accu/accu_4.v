
module accu (
    input clk, // Clock input for synchronization
    input rst_n, // Active-low reset signal
    input [7:0] data_in, // 8-bit input data for addition
    input valid_in, // Input signal indicating readiness for new data
    output reg valid_out, // Output signal indicating when 4 input data accumulation is reached
    output reg [9:0] data_out // 10-bit output data representing the accumulated sum
);

reg [7:0] accumulator [0:3]; // Accumulator for storing the 4 input data
reg [3:0] count; // Counter for keeping track of received data count

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        valid_out <= 0;
        data_out <= 0;
        count <= 0;
        accumulator[0] <= 0;
        accumulator[1] <= 0;
        accumulator[2] <= 0;
        accumulator[3] <= 0;
    end else begin
        if (valid_in) begin
            accumulator[count] <= data_in;
            count <= count + 1;
            if (count == 3) begin
                data_out <= accumulator[0] + accumulator[1] + accumulator[2] + accumulator[3];
                valid_out <= 1;
            end
        end
    end
end

endmodule