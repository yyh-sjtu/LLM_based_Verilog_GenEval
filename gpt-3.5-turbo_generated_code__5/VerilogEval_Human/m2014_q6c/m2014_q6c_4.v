module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    wire in_A, in_B, in_C, in_D, in_E, in_F;
    
    assign in_A = (y == 6'b000001);
    assign in_B = (y == 6'b000010);
    assign in_C = (y == 6'b000100);
    assign in_D = (y == 6'b001000);
    assign in_E = (y == 6'b010000);
    assign in_F = (y == 6'b100000);
    
    always @*
    begin
        if (in_A)
        begin
            Y2 = w;
            Y4 = 1'b1;
        end
        else if (in_B)
        begin
            Y2 = w;
            Y4 = w;
        end
        else if (in_C)
        begin
            Y2 = 1'b0;
            Y4 = 1'b1;
        end
        else if (in_D)
        begin
            Y2 = w;
            Y4 = (y[2] | y[4]);
        end
        else if (in_E)
        begin
            Y2 = 1'b1;
            Y4 = (y[2] & ~y[4]);
        end
        else if (in_F)
        begin
            Y2 = 1'b0;
            Y4 = w;
        end
    end
    
endmodule

