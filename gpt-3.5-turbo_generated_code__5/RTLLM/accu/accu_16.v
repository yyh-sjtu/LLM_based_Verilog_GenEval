module accu(
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire valid_in,
    output reg valid_out,
    output reg [9:0] data_out
);

reg [7:0] accumulator [0:3];
reg [2:0] count;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (int i=0; i<4; i=i+1) begin
            accumulator[i] <= 8'b0;
        end
        count <= 3'b0;
        valid_out <= 1'b0;
        data_out <= 10'b0;
    end else begin
        if (valid_in && count < 3'd3) begin
            accumulator[count] <= data_in;
            count <= count + 1;
            data_out <= 10'b0;
            valid_out <= 1'b0;
        end else if (valid_in && count == 3'd3) begin
            accumulator[count] <= data_in;
            data_out <= {1'b0, accumulator[0]} + {1'b0, accumulator[1]} + {1'b0, accumulator[2]} + {1'b0, accumulator[3]};
            valid_out <= 1'b1;
            count <= 3'b0;
        end
    end
end

endmodule

