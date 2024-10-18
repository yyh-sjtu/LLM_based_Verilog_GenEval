
module multi_16bit (
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [15:0] ain,
    input wire [15:0] bin,
    output wire [31:0] yout,
    output wire done
);

    reg [15:0] areg;
    reg [15:0] breg;
    reg [31:0] yout_r;
    reg [3:0] i;
    reg done_r;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            i <= 0;
            areg <= 0;
            breg <= 0;
            yout_r <= 0;
            done_r <= 0;
        end else begin
            if (start) begin
                if (i < 17) begin
                    i <= i + 1;
                end else begin
                    i <= 0;
                end
            end else begin
                i <= 0;
            end

            if (i == 16) begin
                done_r <= 1;
            end else if (i == 17) begin
                done_r <= 0;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            yout_r <= 0;
        end else begin
            if (start) begin
                if (i == 0) begin
                    areg <= ain;
                    breg <= bin;
                end else begin
                    if (areg[i-1]) begin
                        yout_r <= {breg << (i-1), {16-(i-1){1'b0}}};
                    end
                end
            end
        end
    end

    assign yout = yout_r;
    assign done = done_r;

endmodule