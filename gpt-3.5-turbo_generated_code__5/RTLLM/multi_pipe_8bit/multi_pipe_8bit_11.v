module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;
reg [1:0] count;
wire [15:0] temp;
reg [15:0] sum;
reg [15:0] mul_out_reg;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_a_reg <= 8'b0;
        mul_b_reg <= 8'b0;
        count <= 2'b0;
        mul_en_out <= 1'b0;
        sum <= 16'b0;
        mul_out_reg <= 16'b0;
    end else begin
        // Input Control
        mul_en_out <= mul_en_in;
        
        // Input Registers
        if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end

        // Partial Product Generation
        assign temp[0] = (mul_b_reg[0]) ? mul_a_reg : 8'b0;
        assign temp[1] = (mul_b_reg[1]) ? mul_a_reg : 8'b0;
        assign temp[2] = (mul_b_reg[2]) ? mul_a_reg : 8'b0;
        assign temp[3] = (mul_b_reg[3]) ? mul_a_reg : 8'b0;
        assign temp[4] = (mul_b_reg[4]) ? mul_a_reg : 8'b0;
        assign temp[5] = (mul_b_reg[5]) ? mul_a_reg : 8'b0;
        assign temp[6] = (mul_b_reg[6]) ? mul_a_reg : 8'b0;
        assign temp[7] = (mul_b_reg[7]) ? mul_a_reg : 8'b0;

        // Partial Sum Calculation
        always @(posedge clk) begin
            if (mul_en_in) begin
                case (count)
                    2'b00: sum <= {16'd0, temp[0]};
                    2'b01: sum <= {16'd0, temp[1]} + sum;
                    2'b10: sum <= {16'd0, temp[2]} + sum;
                    2'b11: sum <= {16'd0, temp[3]} + sum;
                endcase
                count <= count + 1;
            end
        end

        // Final Product Calculation
        always @(posedge clk) begin
            if (mul_en_in && (count == 2'b11)) begin
                mul_out_reg <= sum;
            end
        end

        // Output Assignment
        if (mul_en_out) begin
            mul_out <= mul_out_reg;
        end else begin
            mul_out <= 16'b0;
        end
    end
end

endmodule

