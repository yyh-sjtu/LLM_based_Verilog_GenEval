module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    reg [511:0] next_q;
    
    always @(posedge clk) begin
        if(load) begin
            q <= data; // Load input data
        end else begin
            // Calculate next state
            for(int i = 0; i < 512; i = i + 1) begin
                if(i == 0) begin
                    // Left boundary, q[-1] = 0
                    if(q[1:0] == 2'b11)
                        next_q[i] = 1'b0;
                    else if(q[1:0] == 2'b10)
                        next_q[i] = 1'b1;
                    else if(q[1:0] == 2'b01)
                        next_q[i] = 1'b1;
                    else // q[1:0] == 2'b00
                        next_q[i] = 1'b0;
                end else if(i == 511) begin
                    // Right boundary, q[512] = 0
                    if(q[510:509] == 2'b11)
                        next_q[i] = 1'b0;
                    else if(q[510:509] == 2'b10)
                        next_q[i] = 1'b1;
                    else if(q[510:509] == 2'b01)
                        next_q[i] = 1'b1;
                    else // q[510:509] == 2'b00
                        next_q[i] = 1'b0;
                end else begin
                    // Inner cells
                    if(q[i+1:i-1] == 3'b111)
                        next_q[i] = 1'b0;
                    else if(q[i+1:i-1] == 3'b110)
                        next_q[i] = 1'b1;
                    else if(q[i+1:i-1] == 3'b101)
                        next_q[i] = 1'b1;
                    else if(q[i+1:i-1] == 3'b100)
                        next_q[i] = 1'b0;
                    else if(q[i+1:i-1] == 3'b011)
                        next_q[i] = 1'b1;
                    else if(q[i+1:i-1] == 3'b010)
                        next_q[i] = 1'b1;
                    else if(q[i+1:i-1] == 3'b001)
                        next_q[i] = 1'b1;
                    else // q[i+1:i-1] == 3'b000
                        next_q[i] = 1'b0;
                end
            end
            
            q <= next_q; // Update state
        end
    end
    
endmodule

