module top_module(
    input x,
    input y,
    output z);

    reg z;

    // Always block to assign z based on inputs x and y
    always @ (x, y) begin
        if (x & !y)
            z <= 1;
        else if (!x & y)
            z <= 0;
        else if (x & y)
            z <= 1;
        else
            z <= 0;
    end

endmodule

