
module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] data_accum;
reg [2:0] count;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 3'b0;
        data_accum <= 8'b0;
        valid_out <= 1'b0;
        data_out <= 10'b0;
    end else if (valid_in) begin
        count <= count + 1;
        data_accum <= data_accum + data_in;
        
        if (count == 3'b11) begin
            valid_out <= 1'b1;
            data_out <= {2'b0, data_accum};
        end else begin
            valid_out <= 1'b0;
        end
    end
end

endmodule