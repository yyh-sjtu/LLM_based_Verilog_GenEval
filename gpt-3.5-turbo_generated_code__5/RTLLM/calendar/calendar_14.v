module calendar (
    input wire CLK,
    input wire RST,
    output reg [5:0] Hours,
    output reg [5:0] Mins,
    output reg [5:0] Secs
);

always @ (posedge CLK or posedge RST)
begin
    if (RST)
        Secs <= 6'b0;
    else if (Secs == 6'b59)
        Secs <= 6'b0;
    else
        Secs <= Secs + 6'b1;
end

always @ (posedge CLK or posedge RST)
begin
    if (RST)
        Mins <= 6'b0;
    else if (Secs == 6'b59 && Mins == 6'b59)
        Mins <= 6'b0;
    else if (Secs == 6'b59)
        Mins <= Mins + 6'b1;
end

always @ (posedge CLK or posedge RST)
begin
    if (RST)
        Hours <= 6'b0;
    else if (Secs == 6'b59 && Mins == 6'b59 && Hours == 6'b23)
        Hours <= 6'b0;
    else if (Mins == 6'b59 && Secs == 6'b59)
        Hours <= Hours + 6'b1;
end

endmodule

