module TopModule (
    input clk,
    input reset,
    input in,
    output out
);
    parameter [0:0] state = 0;
    parameter [0:0] code = 0;
    parameter [0:0] state_shift = 0;
    parameter [0:0] code_shift = 0;
    reg [0:0] state_reg = 0;
    reg [0:0] code_next = 0;
    always @(posedge clk or posedge reset)
    begin
        if (reset == 1'b1)
            state_reg <= 0;
        else
            state_reg <= state_reg + 1'b1;
    end
    always @*
    begin
        case (state_reg)
            0: begin
                code_next = code;
                if (code!= 0)
                    code = code_shift;
                state_reg = state;
            end
            1: begin
                code_next = code;
                if (code!= 0)
                    code = code_shift;
                state_reg = state;
            end
            2: begin
                code_next = code;
                state_reg = state_shift;
            end
            3: begin
                code_next = code;
                state_reg = state_shift;
            end
        endcase
    end
    assign out = code_next;
endmodule

