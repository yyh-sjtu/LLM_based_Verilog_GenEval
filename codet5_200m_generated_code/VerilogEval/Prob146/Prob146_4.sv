module TopModule (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] out_data;
    reg [7:0] out_data_reg;
    reg [2:0] state;
    always @ (posedge clk or posedge reset)
    begin
        if (reset) begin
            out_data <= 8'b0;
            state <= 2'b00;
        end
        else begin
            if (out_data == 8'b0) begin
                case (state)
                    2'b00: begin
                        out_data <= out_data_reg[0];
                    end
                    2'b01: begin
                        out_data <= out_data_reg[1];
                    end
                    2'b10: begin
                        out_data <= out_data_reg[2];
                    end
                    2'b11: begin
                        out_data <= out_data_reg[3];
                    end
                    default: begin
                        state <= 2'b00;
                        out_data <= 8'b0;
                    end
                endcase
            end
        end
    end
    assign done = out_data_reg[2];
    assign out_byte = out_data_reg[3];
endmodule

