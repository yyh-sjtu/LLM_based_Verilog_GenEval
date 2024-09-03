
module signal_generator(
    input clk,
    input rst_n,
    output reg [4:0] wave
);

reg [1:0] state;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        state <= 2'b00;
        wave <= 5'b00000;
    end else begin
        case(state)
            2'b00: begin
                if(wave == 5'b11111) begin
                    state <= 2'b01;
                end else begin
                    wave <= wave + 1;
                end
            end
            2'b01: begin
                if(wave == 5'b00000) begin
                    state <= 2'b00;
                end else begin
                    wave <= wave - 1;
                end
            end
        endcase
    end
end

endmodule