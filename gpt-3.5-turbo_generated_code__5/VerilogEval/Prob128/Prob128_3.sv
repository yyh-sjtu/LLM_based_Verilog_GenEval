module TopModule(
    input clk,
    input reset,
    input [7:0] in,
    output reg done
);

// Define states for the state machine
parameter SEARCHING = 2'b00;
parameter BYTE1 = 2'b01;
parameter BYTE2 = 2'b10;
parameter BYTE3 = 2'b11;

// Define signals for the state machine
reg [1:0] state;
reg [7:0] previous_byte;
reg [7:0] byte_counter;

// Reset logic
always @(posedge clk) begin
    if (reset) begin
        state <= SEARCHING;
        done <= 0;
        byte_counter <= 0;
    end else begin
        // State transitions and logic
        case (state)
            SEARCHING: begin
                if (in[3] == 1) begin
                    state <= BYTE1;
                    previous_byte <= in;
                    byte_counter <= 1;
                end
            end
            BYTE1: begin
                if (byte_counter == 2) begin
                    state <= BYTE2;
                    byte_counter <= 0;
                end
                else begin
                    byte_counter <= byte_counter + 1;
                    previous_byte <= in;
                end
            end
            BYTE2: begin
                if (byte_counter == 2) begin
                    state <= BYTE3;
                    byte_counter <= 0;
                end
                else begin
                    byte_counter <= byte_counter + 1;
                    previous_byte <= in;
                end
            end
            BYTE3: begin
                if (byte_counter == 2) begin
                    state <= SEARCHING;
                    done <= 1;
                end
                else begin
                    byte_counter <= byte_counter + 1;
                    previous_byte <= in;
                end
            end
        endcase
    end
end

endmodule

