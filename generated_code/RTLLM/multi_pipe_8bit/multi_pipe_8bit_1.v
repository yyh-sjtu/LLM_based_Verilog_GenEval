
module multi_pipe_8bit (
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

// Input control register
reg mul_en_out_reg;

// Input registers
reg [7:0] mul_a_reg;
reg [7:0] mul_b_reg;

// Partial product wires
wire [15:0] temp;

// Partial sum registers
reg [15:0] sum [7:0];

// Final product register
reg [15:0] mul_out_reg;

// Input control
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_en_out_reg <= 0;
    end else begin
        mul_en_out_reg <= mul_en_in;
    end
end

assign mul_en_out = mul_en_out_reg[7];

// Input registers update
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_a_reg <= 0;
        mul_b_reg <= 0;
    end else begin
        if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end
    end
end

// Partial product generation
assign temp = { {8{mul_b_reg[0]} & mul_a_reg}, {8{mul_b_reg[1]} & mul_a_reg}, 
                {8{mul_b_reg[2]} & mul_a_reg}, {8{mul_b_reg[3]} & mul_a_reg},
                {8{mul_b_reg[4]} & mul_a_reg}, {8{mul_b_reg[5]} & mul_a_reg},
                {8{mul_b_reg[6]} & mul_a_reg}, {8{mul_b_reg[7]} & mul_a_reg} };

// Partial sum calculation
always @(posedge clk) begin
    if (rst_n == 0) begin
        for (int i = 0; i < 8; i = i + 1) begin
            sum[i] <= 0;
        end
    end else begin
        if (mul_en_out) begin
            for (int i = 0; i < 8; i = i + 1) begin
                sum[i] <= sum[i] + temp[i];
            end
        end
    end
end

// Final product calculation
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_out_reg <= 0;
    end else begin
        if (mul_en_out) begin
            for (int i = 0; i < 8; i = i + 1) begin
                mul_out_reg <= mul_out_reg + sum[i];
            end
        end
    end
end

// Output assignment
always @(posedge clk) begin
    if (rst_n == 0) begin
        mul_out <= 0;
    end else begin
        if (mul_en_out) begin
            mul_out <= mul_out_reg;
        end else begin
            mul_out <= 0;
        end
    end
end

endmodule