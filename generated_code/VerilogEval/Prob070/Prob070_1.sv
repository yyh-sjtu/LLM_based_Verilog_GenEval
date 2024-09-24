
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Calculate out_sop: 2, 7, 15
    assign out_sop = (a ~& b & c & ~d) | (a ~& b & c & d) | (a & b & c & d);

    // Calculate out_pos: 0, 1, 2, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | c | d) & (a | b | c | ~d) & (a | b | ~c | d) &
                     (a | ~b | c | d) & (a | ~b | c | ~d) & 
                     (a | ~b | ~c | d) & (~a | b | c | ~d) & 
                     (~a | b | ~c | d) & (~a | b | ~c | ~d) & 
                     (~a | ~b | c | d);
                     
endmodule