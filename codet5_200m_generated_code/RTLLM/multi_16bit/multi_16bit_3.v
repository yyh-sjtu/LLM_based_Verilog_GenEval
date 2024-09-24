module multi_16bit (
    input clk,
    input rst_n,
    input start,
    input [15:0] ain,
    input [15:0] bin,
    output [31:0] yout,
    output done
);
    reg [15:0] ain_reg;
    reg [15:0] bin_reg;
    reg [31:0] yout_reg;
    reg done_reg;
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            begin
                ain_reg <= 16'h0;
                bin_reg <= 16'h0;
            done_reg <= 1'b0;
            end
        else
            begin
                if(start)
                begin
                    ain_reg <= ain;
                    bin_reg <= bin;
                end
                else
                begin
                    ain_reg <= ain;
                    bin_reg <= bin;
                end
            end
        end
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            begin
                done_reg <= 1'b0;
            end
        else
            begin
                done_reg <= done_reg;
            end
    end
    assign yout = yout_reg;
    assign done = done_reg;
endmodule

