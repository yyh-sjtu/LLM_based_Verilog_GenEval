
module TopModule (
    input clk,
    input reset,
    input data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input ack
);

reg [3:0] delay;
reg [2:0] state;

always @ (posedge clk) begin
    if (reset) begin
        state <= 0;
        delay <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                if (data == 4'b1101) begin
                    delay <= data;
                    state <= 1;
                end
            end
            1: begin
                counting <= 1;
                state <= 2;
            end
            2: begin
                if (count == ((delay + 1) * 1000) - 1) begin
                    counting <= 0;
                    state <= 3;
                end
            end
            3: begin
                done <= 1;
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

always @ (posedge clk) begin
    if (reset) begin
        count <= 4'b0;
    end else if (counting) begin
        if (count == ((delay + 1) * 1000) - 1) begin
            count <= 4'b0;
        else
            count <= count + 1;
    end
end

endmodule