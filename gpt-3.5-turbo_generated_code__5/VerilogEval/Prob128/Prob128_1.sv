
module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output done
);

    reg [2:0] state;
    reg [7:0] byte_count;
    reg done;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            byte_count <= 0;
            done <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (in[3] == 1'b1) begin
                        state <= 3'b001;
                        byte_count <= 1;
                    end
                end
                3'b001: begin
                    byte_count <= byte_count + 1;
                    if (byte_count == 2) begin
                        state <= 3'b010;
                        byte_count <= 0;
                    end
                end
                3'b010: begin
                    byte_count <= byte_count + 1;
                    if (byte_count == 2) begin
                        state <= 3'b000;
                        byte_count <= 0;
                        done <= 1;
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end

endmodule