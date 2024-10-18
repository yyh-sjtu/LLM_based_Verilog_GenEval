module top_module(
    output reg out
  );
    
    // Always drive the output to 0
    always @(*) begin
      out = 0;
    end

  endmodule

module dut(
      .out(out)
    );

  endmodule

