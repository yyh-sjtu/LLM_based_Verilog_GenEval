module lfsr( 
    input clk,
    input reset,
    output [4:0] q
); 

reg [4:0] r_reg;
wire [4:0] r_next;
wire feedback_value;

assign feedback_value = r_reg[4] ^ r_reg[2]; 

always @(posedge clk or posedge reset)
begin
    if (reset)
        r_reg <= 5'b1;
    else
        r_reg <= r_next;
end

assign r_next = {feedback_value, r_reg[4:1]};
assign q = r_reg;

endmodule

