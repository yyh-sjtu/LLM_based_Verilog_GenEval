
module TopModule (
    input clk,
    input reset,
    input in,
    output done
);
    reg [2:0] state;
    reg start_bit_detected;
    reg [7:0] data_bits_received;
    reg stop_bit_detected;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            start_bit_detected <= 1'b0;
            data_bits_received <= 8'b0;
            stop_bit_detected <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // IDLE state
                    data_bits_received <= 8'b0;
                    start_bit_detected <= (in == 1'b0);
                    if (start_bit_detected)
                        state <= 3'b001;
                end
                
                3'b001: begin // DATA state
                    state <= 3'b010;
                end
                
                3'b010: begin // RECEIVE state
                    data_bits_received <= {data_bits_received[6:0], in};
                    state <= 3'b011;
                end
                
                3'b011: begin // VERIFY_STOP state
                    stop_bit_detected <= (in == 1'b1);
                    if (stop_bit_detected)
                        state <= 3'b000;
                end
            endcase
        end
    end
    
    assign done = stop_bit_detected;
    
endmodule