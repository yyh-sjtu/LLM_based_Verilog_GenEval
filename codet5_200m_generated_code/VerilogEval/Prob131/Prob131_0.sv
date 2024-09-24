module top_level (
	input x,
	input y,
	output z
);
    A a (
        .y(y),
        .z(z)
    );
    B b (
        .y(y),
        .z(z)
    );
endmodule

