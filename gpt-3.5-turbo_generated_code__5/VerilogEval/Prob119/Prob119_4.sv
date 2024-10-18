
module TopModule(
  input  wire clk,
  input  wire areset,
  input  wire in,
  output wire out
);

  // States
  localparam A = 2'b00;
  localparam B = 2'b01;
  localparam C = 2'b10;
  localparam D = 2'b11;
  
  // Registers
  reg [1:0] state;
  reg       next_state;
  
  // Outputs
  reg       output;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset
      state <= A;
      output <= 0;
    end else begin
      // State transitions and outputs
      case(state)
        A: begin
          if (in) begin
            next_state <= B;
          end else begin
            next_state <= A;
          end
          output <= 0;
        end
        B: begin
          if (in) begin
            next_state <= C;
          end else begin
            next_state <= B;
          end
          output <= 0;
        end
        C: begin
          if (in) begin
            next_state <= D;
          end else begin
            next_state <= A;
          end
          output <= 0;
        end
        D: begin
          if (in) begin
            next_state <= B;
          end else begin
            next_state <= C;
          end
          output <= 1;
        end
      endcase
    end
  end
  
  // Output assignment
  assign out = output;
  
endmodule