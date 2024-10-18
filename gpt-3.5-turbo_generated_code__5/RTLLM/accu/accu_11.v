module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
    );
    
    reg [7:0] accumulation [0:3]; // Array to store input data for accumulation
    reg [3:0] count; // Counter to keep track of number of input data received
    
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            // Reset the accumulation array
            accumulation <= {8{8'b0}};
            count <= 4'b0;
            data_out <= 10'b0;
            valid_out <= 1'b0;
        end
        else begin
            if (valid_in) begin
                // Add the input data to the accumulation array
                accumulation[count] <= data_in;
                count <= count + 1;
                
                if (count == 4) begin
                    // Accumulate the input data and output the result
                    for (int i=0; i<4; i=i+1) begin
                        data_out <= data_out + accumulation[i];
                    end
                    valid_out <= 1'b1;
                end
                else begin
                    valid_out <= 1'b0;
                end
            end
        end
    end
endmodule

