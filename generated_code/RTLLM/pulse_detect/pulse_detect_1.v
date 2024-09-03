
module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

reg [1:0] state;

parameter IDLE = 2'b00;
parameter P1 = 2'b01;
parameter P2 = 2'b10;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end else begin
        case (state)
            IDLE: begin
                if(data_in == 1)
                    state <= P1;
                else
                    state <= IDLE;
            end
            P1: begin
                state <= P2;
            end
            P2: begin
                state <= IDLE;
            end
            default: state <= IDLE;
        endcase

        if (state == P2)
            data_out <= 1;
        else
            data_out <= 0;
    end
end

endmodule