
module A (
    input x,
    input y,
    output reg z
);
    always @* begin
        z = (x & y) & x;
    end
endmodule

module B (
    input x,
    input y,
    output reg z
);
    always @* begin
        case({x,y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end
endmodule

module top (
    input x,
    input y,
    output reg z
);
    wire a_out, b_out;
    
    A a1 (.x(x), .y(y), .z(a_out));
    B b1 (.x(x), .y(y), .z(b_out));
    
    A a2 (.x(x), .y(y), .z(a_out));
    B b2 (.x(x), .y(y), .z(b_out));
    
    assign z = a_out ^ b_out;
endmodule