
module multi_16bit(
    input clk,      // Chip clock signal
    input rst_n,    // Active-low reset signal
    input start,    // Chip enable signal to initiate multiplication
    input [15:0] ain,  // Multiplicand input signal
    input [15:0] bin,  // Multiplier input signal
    output reg [31:0] yout,  // Product output signal
    output reg done  // Completion flag signal
);

reg [4:0] i;  // Shift count register
reg [15:0] areg, breg;  // Multiplicand and multiplier registers
reg [31:0] yout_r;  // Product register
reg done_r;  // Multiplication completion flag register

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i <= 5'b0;
    end else begin
        if (start && i < 5'b10000) begin
            i <= i + 1;
        end else if (!start) begin
            i <= 5'b0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done_r <= 1'b0;
    end else begin
        if (i == 5'b10000) begin
            done_r <= 1'b1;
        end else if (i == 5'b10001) begin
            done_r <= 1'b0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        areg <= 16'b0;
        breg <= 16'b0;
        yout_r <= 32'b0;
    end else begin
        if (start) begin
            case(i)
                5'd0: begin
                    areg <= ain;
                    breg <= bin;
                end
                default: begin
                    if (areg[i-1] == 1'b1) begin
                        yout_r <= yout_r + ({breg, 16'b0} << (i-1));
                    end
                end
            endcase
        end
    end
end

assign yout = yout_r;
assign done = done_r;

endmodule