module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] accumulator [3:0];
reg [3:0] count;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 4'b0;
        for (int i=0; i<4; i=i+1) begin
            accumulator[i] <= 8'b0;
        end
        data_out <= 10'b0;
        valid_out <= 1'b0;
    end
    else begin
        if (valid_in) begin
            accumulator[count] <= data_in;
            count <= count + 1;
            if (count == 4) begin
                for (int i=0; i<4; i=i+1) begin
                    data_out <= data_out + accumulator[i];
                end
                valid_out <= 1'b1;
                count <= 4'b0;
            end
        end
    end
end

endmodule

