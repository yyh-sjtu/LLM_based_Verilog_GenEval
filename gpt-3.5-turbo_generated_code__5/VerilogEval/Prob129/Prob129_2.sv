
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // State definitions
  typedef enum logic [1:0] {
    S0,
    S1,
    S2
  } State;

  // Registers
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Output logic
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
      current_state <= S0;
    end
    else begin
      current_state <= next_state;
    end
  end

  always @(current_state or x) begin
    case (current_state)
      S0: begin
        z <= 0;
        if (x == 1'b1) begin
          next_state <= S1;
        end
        else begin
          next_state <= S0;
        end
      end
      
      S1: begin
        if (x == 1'b0) begin
          next_state <= S2;
        end
        else begin
          next_state <= S1;
        end
      end
      
      S2: begin
        if (x == 1'b1) begin
          z <= 1;
          next_state <= S0;
        end
        else begin
          z <= 0;
          next_state <= S2;
        end
      end
      
      default: begin
        next_state <= S0;
      end
    endcase
  end

endmodule