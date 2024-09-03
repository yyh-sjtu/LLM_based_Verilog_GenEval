
module calendar (
    input wire CLK,
    input wire RST,
    output reg [5:0] Hours,
    output reg [5:0] Mins,
    output reg [5:0] Secs
);

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        Secs <= 6'b000000;
    end else begin
        if (Secs == 6'b111011) begin // 59 in binary
            Secs <= 6'b000000;
        end else begin
            Secs <= Secs + 1;
        end
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        Mins <= 6'b000000;
    end else begin
        if (Mins == 6'b111011) begin // 59 in binary
            Mins <= 6'b000000;
        end else begin
            if (Secs == 6'b111011) begin // 59 in binary
                Mins <= Mins + 1;
            end
        end
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        Hours <= 6'b000000;
    end else begin
        if (Hours == 6'b10111 && Mins == 6'b111011 && Secs == 6'b111011) begin // 23, 59, 59 in binary
            Hours <= 6'b000000;
        end else begin
            if (Mins == 6'b111011 && Secs == 6'b111011) begin // 59 in binary
                Hours <= Hours + 1;
            end
        end
    end
end

endmodule