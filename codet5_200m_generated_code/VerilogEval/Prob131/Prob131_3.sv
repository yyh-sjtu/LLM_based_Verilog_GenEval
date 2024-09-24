module top_level (
	input x,
	input y,
	output z
);
    A A0 (
        .y(y),
        .z(z)
    );
    B B0 (
        .y(y),
        .z(z)
    );
endmodule

