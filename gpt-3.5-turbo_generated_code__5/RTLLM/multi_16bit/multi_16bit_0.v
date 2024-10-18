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
reg [31:0] areg, breg, yout_r;
reg done_r;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        i <= 0;
        areg <= 0;
        breg <= 0;
        yout_r <= 0;
        done_r <= 0;
    end else begin
        if (start && (i < 4'd16)) begin
            i <= i + 1;
        end else if (!start) begin
            i <= 0;
        end
        if (i == 4'd16) begin
            done_r <= 1;
        end else if (i == 4'd17) begin
            done_r <= 0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        done <= 0;
    end else begin
        done <= done_r;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        yout <= 0;
    end else begin
        if (start) begin
            areg <= ain;
            breg <= bin;
        end
        if (i > 0 && i < 4'd17) begin
            if (areg[i-1] == 1'b1) begin
                yout_r <= yout_r + (breg << (i-1));
            end
        end
        yout <= yout_r;
    end
end

endmodule

