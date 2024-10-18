
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

// Define state variables
reg [2:0] currentState;
reg [2:0] nextState;

// Synchronous active high reset
always @(posedge clk) begin
  if (reset) begin
    currentState <= 3'b000;
  end else begin
    currentState <= nextState;
  end
end

// State-assigned table
always @(currentState, x) begin
  case (currentState)
    3'b000:
      begin
        if (x == 1'b0) begin
          nextState = 3'b000;
          z = 1'b0;
        end else begin
          nextState = 3'b001;
          z = 1'b0;
        end
      end
    
    3'b001:
      begin
        if (x == 1'b0) begin
          nextState = 3'b001;
          z = 1'b0;
        end else begin
          nextState = 3'b100;
          z = 1'b0;
        end
      end
      
    3'b010:
      begin
        if (x == 1'b0) begin
          nextState = 3'b010;
          z = 1'b0;
        end else begin
          nextState = 3'b001;
          z = 1'b0;
        end
      end
      
    3'b011:
      begin
        if (x == 1'b0) begin
          nextState = 3'b001;
          z = 1'b1;
        end else begin
          nextState = 3'b010;
          z = 1'b1;
        end
      end
      
    3'b100:
      begin
        if (x == 1'b0) begin
          nextState = 3'b011;
          z = 1'b1;
        end else begin
          nextState = 3'b100;
          z = 1'b1;
        end
      end
      
    default:
      begin
        nextState = 3'b000;
        z = 1'b0;
      end
  endcase
end

endmodule