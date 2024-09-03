
module calendar (
    input CLK,
    input RST,
    output reg [5:0] Hours,
    output reg [5:0] Mins,
    output reg [5:0] Secs
);

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        Secs <= 6'b000000;
    end else begin
        if (Secs == 6'b111011) begin
            Secs <= 6'b000000;  // Reset seconds
        end else begin
            Secs <= Secs + 1;   // Increment seconds
        end
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        Mins <= 6'b000000;
    end else begin
        if ((Mins == 6'b111011) && (Secs == 6'b111011)) begin
            Mins <= 6'b000000;  // Reset minutes
        end else if (Secs == 6'b111011) begin
            Mins <= Mins + 1;   // Increment minutes
        end
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        Hours <= 6'b000000;
    end else begin
        if ((Hours == 6'b10111) && (Mins == 6'b111011) && (Secs == 6'b111011)) begin
            Hours <= 6'b000000;  // Reset hours
        end else if ((Mins == 6'b111011) && (Secs == 6'b111011)) begin
            Hours <= Hours + 1;  // Increment hours
        end
    end
end

endmodule