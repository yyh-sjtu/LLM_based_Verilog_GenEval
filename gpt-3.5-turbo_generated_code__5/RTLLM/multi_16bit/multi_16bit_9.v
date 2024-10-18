module multi_16bit (
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [15:0] ain,
    input wire [15:0] bin,
    output reg [31:0] yout,
    output reg done
);

reg [3:0] i;
reg [15:0] areg, breg;
reg [31:0] yout_r;
reg done_r;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i <= 4'b0000;
    end else begin
        if (start && (i < 4'b1000)) begin
            i <= i + 1;
        end else if (!start) begin
            i <= 4'b0000;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done_r <= 1'b0;
    end else begin
        if (i == 4'b1000) begin
            done_r <= 1'b1;
        end else if (i == 4'b10001) begin
            done_r <= 1'b0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        areg <= 16'd0;
        breg <= 16'd0;
        yout_r <= 32'd0;
    end else begin
        if (start) begin
            if (i == 4'b0000) begin
                areg <= ain;
                breg <= bin;
            end else begin
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

