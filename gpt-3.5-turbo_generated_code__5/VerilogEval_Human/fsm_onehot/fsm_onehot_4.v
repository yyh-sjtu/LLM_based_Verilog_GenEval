
assign out1 = (state[5] & ~in) | (state[6] & in);
assign out2 = state[7];
always @* begin
    case(state)
        10'b0000000001: next_state = 10'b0000000010;
        10'b0000000010: next_state = 10'b0000000100;
        10'b0000000100: next_state = 10'b0000001000;
        10'b0000001000: next_state = 10'b0000010001;
        10'b0000010001: next_state = 10'b0000000001;
        10'b0000000011: next_state = 10'b0000000100;
        10'b0000000101: next_state = 10'b0000001010;
        10'b0000001010: next_state = 10'b0000001011;
        10'b0000001011: next_state = 10'b0000000001;
        10'b0000000110: next_state = 10'b0000001000;
        10'b0000001100: next_state = 10'b0000000010;
        10'b0000011000: next_state = 10'b0000000010;
        10'b0000011100: next_state = 10'b0000000100;
        default: next_state = 10'b0000000001;
    endcase
end