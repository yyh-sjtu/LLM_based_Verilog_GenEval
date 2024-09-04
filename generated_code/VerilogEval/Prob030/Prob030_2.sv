
module TopModule (
    input [254:0] in,
    output reg [7:0] out
);

// Intermediate signals
reg [7:0] count;
reg [7:0] temp;

always @(*)
begin
    temp = in[0] + in[1];
    for (int i = 2; i < 255; i = i+1) begin
        temp = temp + in[i];
    end
    
    count = temp;
    
    out = count;
end

endmodule