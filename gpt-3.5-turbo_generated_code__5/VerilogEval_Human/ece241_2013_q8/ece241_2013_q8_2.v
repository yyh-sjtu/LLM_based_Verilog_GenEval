module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg detection;

always @(posedge clk or negedge aresetn)
begin
    if (!aresetn)
        state <= 0;
    else
        case(state)
            0: if (x == 1'b1)
                   state <= 1;
               else
                   state <= 0;
            1: if (x == 1'b0)
                   state <= 2;
               else if (x == 1'b1)
                   state <= 1;
               else
                   state <= 0;
            2: if (x == 1'b1)
                   begin
                       state <= 1;
                       detection <= 1;
                   end
               else if (x == 1'b0)
                   state <= 2;
               else
                   state <= 0;
            default: state <= 0;
        endcase
end

always @(negedge aresetn)
begin
    if (!aresetn)
        z <= 0;
    else if (detection)
        z <= 1;
    else
        z <= 0;
    detection <= 0;
end

endmodule

