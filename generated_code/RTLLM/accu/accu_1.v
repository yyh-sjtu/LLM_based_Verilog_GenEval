
module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] data_accum [3:0];
reg [1:0] counter;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        counter <= 0;
        data_out <= 10'h000;
        valid_out <= 0;
        data_accum <= 8'h000;
    end else begin
        if (valid_in) begin
            data_accum[counter] <= data_in;
            counter <= counter + 1;
            if (counter == 3) begin
                data_out <= data_accum[0] + data_accum[1] + data_accum[2] + data_accum[3];
                valid_out <= 1;
            end
        end
        if (valid_out) begin
            valid_out <= 0;
        end
    end
end

endmodule