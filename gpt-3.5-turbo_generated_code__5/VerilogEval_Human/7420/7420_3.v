module top_module(
    input [7:0] p1, 
    output p1y, 
    input [7:0] p2, 
    output p2y
);

    wire temp1;
    wire temp2;

    // First 4-input NAND gate
    nand_gate n1(
        .p1(p1[0]), 
        .p2(p1[1]), 
        .p3(p1[2]), 
        .p4(p1[3]), 
        .y(temp1)
    );

    // Second 4-input NAND gate
    nand_gate n2(
        .p1(p2[0]), 
        .p2(p2[1]), 
        .p3(p2[2]), 
        .p4(p2[3]), 
        .y(temp2)
    );

    // Output connections
    assign p1y = temp1;
    assign p2y = temp2;

endmodule

module nand_gate(
    input p1, 
    input p2, 
    input p3, 
    input p4, 
    output y
);

    assign y = ~(p1 & p2 & p3 & p4);

endmodule

