
module TopModule(
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states using one-hot encoding
    parameter A = 2'b01;
    parameter B = 2'b10;
    
    // Define state and next state registers
    reg [1:0] state, next_state;
    
    // Output register for z
    always @*
    begin
        case(state)
            A: z = 1'b0;
            B: z = 1'b1;
        endcase
    end

    always @(posedge clk or posedge areset)
    begin
        if(areset)
            state <= A;
        else
            state <= next_state;
    end

    always @*
    begin
        case(state)
            A: begin
                if(x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if(x)
                    next_state = B;
                else
                    next_state = B;
            end
        endcase
    end

endmodule