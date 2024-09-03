
module signal_generator (
    input wire clk,
    input wire rst_n,
    output reg [4:0] wave
);

reg [1:0] state;

always @ (posedge clk or negedge rst_n)
begin
    if (~rst_n) begin
        state <= 2'b00;
        wave <= 5'b00000;
    end
    else begin
        case (state)
            2'b00: begin // Increment wave
                wave <= wave + 1;
                if (wave == 5'b11111) // wave == 31
                    state <= 2'b01;
            end
            2'b01: begin // Decrement wave
                wave <= wave - 1;
                if (wave == 5'b00000) // wave == 0
                    state <= 2'b00;
            end
        endcase
    end
end

endmodule