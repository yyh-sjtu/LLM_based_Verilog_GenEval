
module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output reg [23:0] out_bytes,
    output reg done
);
    
    // State Encoding
    typedef enum reg [1:0] {
        IDLE      = 2'b00,
        BYTE1     = 2'b01,
        BYTE2     = 2'b10,
        BYTE3     = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next State Logic
    always @* begin
        case (current_state)
            IDLE: begin
                if (in[3]) begin // looking for start of message
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
                done = 0; // done signal is not asserted
            end
            
            BYTE1: begin
                next_state = BYTE2;
                done = 0; // done signal is not asserted
            end
            
            BYTE2: begin
                next_state = BYTE3;
                done = 0; // done signal is not asserted
            end
            
            BYTE3: begin
                next_state = IDLE;
                done = 1; // done signal is asserted
            end
            
            default: begin
                next_state = IDLE;
                done = 0;
            end
        endcase
    end
    
    // Data Path Logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0; // reset output
        end else begin
            case (current_state)
                BYTE1: begin
                    out_bytes[23:16] <= in; // Store 1st byte
                end
                
                BYTE2: begin
                    out_bytes[15:8] <= in; // Store 2nd byte
                end
                
                BYTE3: begin
                    out_bytes[7:0] <= in; // Store 3rd byte
                end
                
                default: begin
                    // No change to out_bytes in IDLE or any other state
                end
            endcase
        end
    end

endmodule