
module TopModule (
  input  clk,
  input  resetn,
  input  [2:0] r,
  output [2:0] g
);

  // Define the states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  // Define the signals for the state flip-flops
  reg [1:0] state;
  reg [1:0] next_state;

  // Define the output signals
  reg [2:0] g_next;
  
  // Define the state transition logic
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Define the state table logic
  always @(state or r) begin
    case (state)
      A: begin
        if (r[2]) begin
          next_state = A;
        end else if (r[1]) begin
          next_state = C;
        end else if (r[0]) begin
          next_state = B;
        end else begin
          next_state = D;
        end
      end
      B: begin
        if (r[0]) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      C: begin
        if (r[1]) begin
          next_state = C;
        end else begin
          next_state = A;
        end
      end
      D: begin
        next_state = A;
      end
    endcase
  end

  // Define the output logic
  always @(state) begin
    case (state)
      A: g_next = 3'b000;
      B: g_next = 3'b001;
      C: g_next = 3'b010;
      D: g_next = 3'b000;
    endcase
  end

  // Assign the outputs
  assign g = g_next;

endmodule