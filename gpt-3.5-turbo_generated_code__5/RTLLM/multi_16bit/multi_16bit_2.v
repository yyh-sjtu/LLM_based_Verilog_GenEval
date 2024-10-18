module multi_16bit (
    input clk,
    input rst_n,
    input start,
    input [15:0] ain,
    input [15:0] bin,
    output reg [31:0] yout,
    output reg done
);

reg [3:0] i;
reg [15:0] areg, breg;
reg [31:0] yout_r;
reg done_r;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        i <= 4'b0000;
        areg <= 16'b0000000000000000;
        breg <= 16'b0000000000000000;
        yout_r <= 32'b00000000000000000000000000000000;
        done_r <= 1'b0;
    end else begin
        if (start && i < 4'b1000) begin
            i <= i + 1;
        end else if (!start) begin
            i <= 4'b0000;
        end
        
        if (i == 4'b1000) begin
            done_r <= 1'b1;
        end else if (i == 4'b10001) begin
            done_r <= 1'b0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        areg <= 16'b0000000000000000;
        breg <= 16'b0000000000000000;
        yout_r <= 32'b00000000000000000000000000000000;
    end else begin
        if (i == 4'b0000) begin
            areg <= ain;
            breg <= bin;
        end else if (i > 4'b0000 && i < 4'b10000) begin
            if (areg[i-1] == 1'b1) begin
                yout_r <= yout_r + ({breg, 16'b0000000000000000} << (i-1));
            end
        end
    end
end

assign yout = yout_r;
assign done = done_r;

endmodule

