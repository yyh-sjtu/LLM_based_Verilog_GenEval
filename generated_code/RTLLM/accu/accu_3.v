
module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] data_buffer [3:0];
reg [3:0] data_count;
reg [9:0] temp_data_out;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        valid_out <= 0;
        data_out <= 10'b0;
        data_count <= 0;
        temp_data_out <= 10'b0;
        data_buffer <= {8'b0, 8'b0, 8'b0, 8'b0};
    end else begin
        if (valid_in) begin
            data_buffer[data_count] <= data_in;
            data_count <= data_count + 1;
            if (data_count == 3) begin
                temp_data_out <= data_buffer[0] + data_buffer[1] + data_buffer[2] + data_buffer[3];
                data_out <= temp_data_out;
                valid_out <= 1;
            end else begin
                data_out <= 10'b0;
                valid_out <= 0;
            end
        end
    end
end

endmodule