
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
    if (!rst_n) begin
        i <= 0;
    end else if (start && (i < 17)) begin
        i <= i + 1;
    end else if (!start) begin
        i <= 0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done_r <= 0;
    end else if (i == 16) begin
        done_r <= 1;
    end else if (i == 17) begin
        done_r <= 0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        areg <= 0;
        breg <= 0;
        yout_r <= 0;
    end else begin
        if (start) begin
            if (i == 0) begin
                areg <= ain;
                breg <= bin;
            end else if ((i > 0) && (i < 17)) begin
                if (areg[i-1] == 1) begin
                    yout_r <= {breg << (i-1), 16'b0};
                end
            end
        end
    end
end

assign yout = yout_r;
assign done = done_r;

endmodule