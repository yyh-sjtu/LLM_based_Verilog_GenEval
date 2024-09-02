module verified_adder_16bit(
    input   wire    [15:0]  a,
    input   wire    [15:0]  b,
    input   wire            c_up,
    
    output wire     [15:0]  y,
    output wire             Co
);
 
        wire    Co_temp;
 
        add8    add8_inst1(
            .a          (a[15:8]),
            .b          (b[15:8]),
            .c_up       (Co_temp), 
             
            .y          (y[15:8]),
            .Co     (Co)
        );
 
        add8    add8_inst2(
            .a          (a[7:0]),
            .b          (b[7:0]),
            .c_up       (c_up),
             
            .y          (y[7:0]),
            .Co     (Co_temp)
        ); 
 
endmodule

module add8(
    input   wire    [7:0]   a,
    input   wire    [7:0]   b,
    input   wire                c_up,
     
    output wire     [7:0]       y,
    output wire                 Co
);
 
        wire    Co_temp;
 
        add4    add4_inst1(
            .a          (a[7:4]),
            .b          (b[7:4]),
            .c_up       (Co_temp), 
             
            .y          (y[7:4]),
            .Co     (Co)
        );
 
        add4    add4_inst2(
            .a          (a[3:0]),
            .b          (b[3:0]),
            .c_up       (c_up),
             
            .y          (y[3:0]),
            .Co     (Co_temp)
        );
 
 
endmodule

module add4(
    input   wire    [3:0]   a,
    input   wire    [3:0]   b,
    input   wire                c_up,
     
    output wire     [3:0]       y,
    output wire                 Co
);
 
        wire    Co_temp;
 
        add2    add2_inst1(
            .a          (a[3:2]),
            .b          (b[3:2]),
            .c_up       (Co_temp), 
             
            .y          (y[3:2]),
            .Co     (Co)
        );
 
        add2    add2_inst2(
            .a          (a[1:0]),
            .b          (b[1:0]),
            .c_up       (c_up),
             
            .y          (y[1:0]),
            .Co     (Co_temp)
        ); 
 
endmodule

module add2(
    input   wire    [1:0]   a,
    input   wire    [1:0]   b,
    input   wire                c_up,
     
    output wire     [1:0]       y,
    output wire                 Co
);
 
        wire    Co_temp;

        add1    add1_inst1(
            .a          (a[1]),
            .b          (b[1]),
            .c_up       (Co_temp), 
             
            .y          (y[1]),
            .Co     (Co)
        );
 
        add1    add1_inst2(
            .a          (a[0]),
            .b          (b[0]),
            .c_up       (c_up),
             
            .y          (y[0]),
            .Co     (Co_temp)
        );
         
endmodule

module add1(
    input   wire        a,
    input   wire        b,
    input   wire        c_up,
     
    output wire         y,
    output wire         Co
);
    assign  y   = ((~a)&(~b)&c_up | (~a)&b&(~c_up) | a&(~b)&(~c_up) | (a&b&c_up));
    assign  Co  = ((~a&b&c_up) | (a&~b&c_up) | (a&b&~c_up) | (a&b&c_up));

endmodule