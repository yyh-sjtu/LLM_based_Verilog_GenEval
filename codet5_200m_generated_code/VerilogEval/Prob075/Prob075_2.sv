module TopModule (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] count;
    always @(posedge clk or posedge areset)
        if(~areset)
            count <= 2'b01;
        else if(train_valid)
            count <= count + 2'b1;
    assign state = count;
endmodule

