
module TopModule(
    input clock,
    input a,
    output p,
    output q
    );
    
    // Sequential logic implementation goes here
    
endmodule
module TopModule(
    input clock,
    input a,
    output p,
    output q
    );
    
    reg d, q_internal;
    
    always @(posedge clock)
    begin
        d <= a;
        q_internal <= d;
    end
    
    assign p = q_internal;
    assign q = ~q_internal;
    
endmodule