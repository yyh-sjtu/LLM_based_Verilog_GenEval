module TopModule (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] out_byte_r;
    reg [3:0] state;
    wire [15:0] data_in;
    reg [15:0] data_out;
    assign done = state == 0;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            out_byte_r <= 0;
            out_byte_r <= 0;
        end else begin
            case (state)
                0: begin
                    if (in) begin
                        out_byte_r <= 8'b0;
                        state <= 2;
                    end else begin
                        out_byte_r <= data_in;
                        state <= 1;
                    end
                end
                1: begin
                    if (in) begin
                        out_byte_r <= data_out;
                        state <= 3;
                    end else begin
                        out_byte_r <= 8'b0;
                        state <= 2;
                    end
                end
            endcase
        end
    end
endmodule

