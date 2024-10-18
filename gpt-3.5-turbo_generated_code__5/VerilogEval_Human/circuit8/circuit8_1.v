module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);
 
reg temp;

 
always @(posedge clock) begin
    if(temp == 1'b1 && a == 1'b0) begin
        p <= 1'b0;
        q <= 1'b0;
    end

    else if (temp == 1'b0 && a == 1'b1) begin
        if (q == 1'b1) begin
            p <= 1'b0;
            q <= 1'b0;
        end

        else begin
            p <= 1'b1;
            q <= 1'b0;
        end
    end

    else if (a == 1'b1) begin
        p <= 1'b1;
        q <= 1'b1;
    end

    temp <= a;
end

endmodule

