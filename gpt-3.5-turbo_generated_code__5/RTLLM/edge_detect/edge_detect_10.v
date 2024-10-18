
module edge_detect (
    input wire clk,
    input wire rst_n,
    input wire a,
    output wire rise,
    output wire down
);

    reg prev_a;
    reg rise_sync, down_sync;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            prev_a <= 1'b0;
            rise_sync <= 1'b0;
            down_sync <= 1'b0;
        end else begin
            prev_a <= a;
            if (a && ~prev_a) begin // Rising edge
                rise_sync <= 1'b1;
                down_sync <= 1'b0;
            end else if (~a && prev_a) begin // Falling edge
                rise_sync <= 1'b0;
                down_sync <= 1'b1;
            end else begin
                rise_sync <= rise_sync;
                down_sync <= down_sync;
            end
        end
    end

    assign rise = rise_sync;
    assign down = down_sync;

endmodule