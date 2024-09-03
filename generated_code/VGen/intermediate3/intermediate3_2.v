
assign feedback_value = r_reg[4] ^ r_reg[2] ^ r_reg[1]; 
always @(posedge clk or posedge reset) begin
    if (reset) begin
        r_reg <= 5'b1; // Initial state
    end else begin
        r_reg <= r_next;
    end
end
assign r_next[4:1] = r_reg[3:0]; // Shift right
assign r_next[0] = feedback_value; // XOR feedback value
assign q = r_reg;