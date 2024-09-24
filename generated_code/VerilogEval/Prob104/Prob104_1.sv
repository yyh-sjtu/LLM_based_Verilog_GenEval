
module flipflop (
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule

module mux21 (
    input sel,
    input a,
    input b,
    output reg Y
);

    always @* begin
        if (sel) begin
            Y <= b;
        end else begin
            Y <= a;
        end
    end

endmodule

module TopModule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output Q
);

    wire [2:0] q;
    wire [2:0] q_temp;

    flipflop ff (
        .clk(clk),
        .D(L ? r_in : {q_temp[1] ^ q_temp[2], q_temp[0], q_temp[2]}),
        .Q(q_temp)
    );

    mux21 mux1 (
        .sel(L),
        .a(r_in),
        .b({q_temp[1] ^ q_temp[2], q_temp[0], q_temp[2]}),
        .Y(q)
    );

    assign Q = q[2];

endmodule

module TopHierarchy (
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output [2:0] Q
);

    wire [2:0] Q1, Q2, Q3;

    TopModule module1 (
        .clk(clk),
        .L(L),
        .q_in(q_in),
        .r_in(r_in),
        .Q(Q1)
    );

    TopModule module2 (
        .clk(clk),
        .L(L),
        .q_in(Q1),
        .r_in(r_in),
        .Q(Q2)
    );

    TopModule module3 (
        .clk(clk),
        .L(L),
        .q_in(Q2),
        .r_in(r_in),
        .Q(Q3)
    );

    assign Q = Q3;

endmodule