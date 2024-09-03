module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output valid_out,
    output reg [9:0] data_out
);

reg [7:0] data_accum [3:0];
reg [3:0] count;

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
        data_out <= 10'b0;
        valid_out <= 0;
        data_accum <= {8{8'b0}};
    end else begin
        if (valid_in) begin
            data_accum[count] <= data_in;
            count <= count + 1;
            if (count == 3) begin
                data_out <= data_accum[0] + data_accum[1] + data_accum[2] + data_accum[3];
                valid_out <= 1;
                count <= 0;
            end else begin
                valid_out <= 0;
            end
        end
    end
end

endmodule
