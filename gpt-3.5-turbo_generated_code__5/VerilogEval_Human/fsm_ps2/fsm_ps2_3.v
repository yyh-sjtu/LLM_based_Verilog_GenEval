module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [7:0] byte_count;
    reg [2:0] state;
    reg done_next;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= 0;
            byte_count <= 0;
            done_next <= 0;
        end
        else
        begin
            case (state)
                0: // idle state
                    if (in[3] == 1)
                    begin
                        state <= 1; // assume byte 1 of message
                        byte_count <= 0;
                        done_next <= 0;
                    end
                
                1: // receive byte 1 of message
                    begin
                        byte_count <= byte_count + 1;
                        if (byte_count == 2)
                            state <= 2; // move to next state
                        
                        done_next <= 0;
                    end
                
                2: // receive byte 2 of message
                    begin
                        byte_count <= byte_count + 1;
                        if (byte_count == 2)
                            state <= 3; // move to next state
                        
                        done_next <= 0;
                    end
                
                3: // receive byte 3 of message
                    begin
                        byte_count <= byte_count + 1;
                        if (byte_count == 2)
                            state <= 0; // move back to idle state
                        
                        done_next <= 1; // signal completion of message
                    end
            endcase
        end
    end

    assign done = done_next;
endmodule

