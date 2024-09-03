module truthtable(input x3, input x2, input x1, output reg f );
  always @(*)
    begin
      case({x3, x2, x1})
        3'b000, 3'b001, 3'b011, 3'b101: f = 1;
        default: f = 0;
      endcase
    end
endmodule

