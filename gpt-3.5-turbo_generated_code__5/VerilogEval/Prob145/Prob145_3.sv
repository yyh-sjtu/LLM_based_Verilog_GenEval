
module TopModule (
  input  wire        clock,
  input  wire        a,
  output reg         p,
  output reg         q
);
  
  reg [1:0] state;
  
  always @(posedge clock) begin
    case(state)
      // Initial state, outputs are don't care
      0: begin
          p <= x;
          q <= x;
          if(a)
            state <= 1;
        end
      // Outputs p and q are always 0
      1: begin
          p <= 0;
          q <= x;
          if(!a)
            state <= 2;
        end
      // Outputs p and q depend on input a
      2: begin
          p <= a;
          q <= x;
          if(a)
            state <= 3;
        end
      // Outputs q is always 0, p toggles with a
      3: begin
          p <= ~a;
          q <= x;
          if(!a)
            state <= 0;
        end
      default: state <= 0;
    endcase
  end
endmodule