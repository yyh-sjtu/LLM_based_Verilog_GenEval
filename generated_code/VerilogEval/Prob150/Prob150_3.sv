
// Next-State Logic Equations
assign B3_next = (state == 10'b1100000000) ? 1'b1 : 1'b0;
assign S_next = ((state == 10'b0000000001) && (d == 1'b0)) ? 1'b1 : 1'b0;
assign S1_next = ((state == 10'b0000000010) && (d == 1'b0)) ? 1'b1 : 1'b0;
assign Count_next = ((state == 10'b1000000000) && (counting == 1'b1) && (done_counting == 1'b0)) ? 1'b1 : 1'b0;
assign Wait_next = ((state == 10'b1000000000) && (counting == 1'b1) && (done_counting == 1'b1)) ? 1'b1 : 1'b0;

// Output Logic Equations
assign done = ((state == 10'b1000000000) && (counting == 1'b1) && (done_counting == 1'b1) && (ack == 1'b1)) ? 1'b1 : 1'b0;
assign counting = (state == 10'b1000000000) ? 1'b1 : 1'b0;
assign shift_ena = ((state == 10'b0000000010) || (state == 10'b1000000000) || (state == 10'b1100000000)) ? 1'b1 : 1'b0;