
module counter( 
    input clk,
    input reset,
    output reg [3:0] q
);
    
    reg [3:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0001;
        end else begin
            if (count == 4'b1100) begin
                count <= 4'b0001;
            end else begin
                count <= count + 1;
            end
        end
    end
    
    assign q = count;
    
endmodule