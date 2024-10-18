module calendar (
  input CLK,
  input RST,
  output reg [5:0] Hours,
  output reg [5:0] Mins,
  output reg [5:0] Secs
);

// First always block for updating seconds
always @(posedge CLK or posedge RST) begin
  if (RST) begin
    Secs <= 0;
  end else if (Secs == 59) begin
    Secs <= 0;
  end else begin
    Secs <= Secs + 1;
  end
end

// Second always block for updating minutes
always @(posedge CLK or posedge RST) begin
  if (RST) begin
    Mins <= 0;
  end else if (Mins == 59 && Secs == 59) begin
    Mins <= 0;
  end else if (Secs == 59) begin
    Mins <= Mins + 1;
  end
end

// Third always block for updating hours
always @(posedge CLK or posedge RST) begin
  if (RST) begin
    Hours <= 0;
  end else if (Hours == 23 && Mins == 59 && Secs == 59) begin
    Hours <= 0;
  end else if (Mins == 59 && Secs == 59) begin
    Hours <= Hours + 1;
  end
end

endmodule

