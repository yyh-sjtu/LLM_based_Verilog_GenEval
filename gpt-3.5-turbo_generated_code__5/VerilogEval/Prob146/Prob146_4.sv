
module TopModule (
    input  wire clk,
    input  wire in,
    input  wire reset,
    output wire [7:0] out_byte,
    output wire done
);
    // State definitions
    localparam IDLE = 2'b00;
    localparam START_BIT = 2'b01;
    localparam DATA_BITS = 2'b10;
    localparam STOP_BIT = 2'b11;

    // State register
    reg [1:0] state;

    // Data storage registers
    reg [7:0] data_byte;
    reg [3:0] bit_counter;

    // Output registers
    reg [7:0] out_byte_reg;
    reg done_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_byte <= 8'b0;
            bit_counter <= 4'b0;
            out_byte_reg <= 8'b0;
            done_reg <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (!in) begin
                        state <= START_BIT;
                        bit_counter <= 4'b0;
                    end
                end

                START_BIT: begin
                    if (bit_counter == 4) begin
                        state <= DATA_BITS;
                        bit_counter <= 0;
                    end else begin
                        bit_counter <= bit_counter + 1;
                    end
                end

                DATA_BITS: begin
                    if (bit_counter == 8) begin
                        state <= STOP_BIT;
                        bit_counter <= 0;
                    end else begin
                        data_byte[bit_counter] <= in;
                        bit_counter <= bit_counter + 1;
                    end
                end

                STOP_BIT: begin
                    if (!in) begin
                        out_byte_reg <= data_byte;
                        done_reg <= 1'b1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    // Output assignments
    assign out_byte = out_byte_reg;
    assign done = done_reg;

endmodule