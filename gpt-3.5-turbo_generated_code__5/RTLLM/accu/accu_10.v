
module accu(
    input clk,
    input rst_n,
    input [7:0] data_in,
    input valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [31:0] data_accumulated;
reg [3:0] data_counter;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        valid_out <= 0;
        data_out <= 0;
        data_counter <= 0;
        data_accumulated <= 0;
    end else begin
        if (valid_in) begin
            data_accumulated <= data_accumulated + data_in;
            data_counter <= data_counter + 1;
            if (data_counter == 3) begin
                data_out <= data_accumulated;
                valid_out <= 1;
            end else begin
                valid_out <= 0;
            end
        end
    end
end

endmodule