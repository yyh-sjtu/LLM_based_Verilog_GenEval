
module multi_16bit (
    input clk,
    input rst_n,
    input start,
    input [15:0] ain,
    input [15:0] bin,
    output reg [31:0] yout,
    output reg done
);

reg [3:0] i; // Shift count register
reg [15:0] areg; // Multiplicand register
reg [15:0] breg; // Multiplier register
reg [31:0] yout_r; // Product register
reg done_r; // Multiplication completion flag register

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        i <= 4'b0000;
    end else begin
        if (start && i < 16) begin
            i <= i + 1;
        end else begin
            i <= 4'b0000;
        end
    end
    
    if (~rst_n) begin
        done_r <= 1'b0;
    end else begin
        if (i == 4'b1000) begin
            done_r <= 1'b1;
        end else if (i == 4'b10001) begin
            done_r <= 1'b0;
        end
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        areg <= 16'b0;
        breg <= 16'b0;
        yout_r <= 32'b0;
    end else begin
        if (start) begin
            if (i == 4'b0000) begin
                areg <= ain;
                breg <= bin;
            end else if (i > 4'b0000 && i < 4'b10001) begin
                if (areg[i-1]) begin
                    yout_r <= yout_r + (breg << (i-1));
                end
            end
        end
    end
end

assign yout = yout_r;
assign done = done_r;

endmodule