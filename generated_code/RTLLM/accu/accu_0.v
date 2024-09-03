
module accu (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] acc_data [3:0];
reg [7:0] sum;
reg count;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        data_out <= 10'b0;
        valid_out <= 0;
        for (int i = 0; i < 4; i = i + 1) begin
            acc_data[i] <= 8'b0;
        end
        sum <= 8'b0;
        count <= 0;
    end else begin
        if (valid_in == 1) begin
            if (count < 4) begin
                acc_data[count] <= data_in;
                count <= count + 1;
                
                if (count == 3) begin
                    for (int i = 0; i < 4; i = i + 1) begin
                        sum <= sum + acc_data[i];
                    end
                    data_out <= {sum, data_in};
                    valid_out <= 1;
                end
            end
        end
    end
end

endmodule