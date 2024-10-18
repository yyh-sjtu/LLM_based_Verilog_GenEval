
module TopModule(
  input clk,
  input reset,
  input w,
  output reg z
);

  // State declaration
  reg [2:0] state;

  // State encoding
  localparam A = 3'b000;
  localparam B = 3'b001;
  localparam C = 3'b010;
  localparam D = 3'b011;
  localparam E = 3'b100;
  localparam F = 3'b101;

  // State flip-flops
  always @(posedge clk) begin
    if (reset)
      state <= A;
    else begin
      case(state)
        A: if(w) state <= B; else state <= A;
        B: if(w) state <= C; else state <= D;
        C: if(w) state <= E; else state <= D;
        D: if(w) state <= F; else state <= A;
        E: if(w) state <= E; else state <= D;
        F: if(w) state <= C; else state <= D;
        default: state <= A;
      endcase
    end
  end

  // FSM output logic
  always @(state) begin
    case(state)
      E: z <= 1'b1;
      default: z <= 1'b0;
    endcase
  end

endmodule