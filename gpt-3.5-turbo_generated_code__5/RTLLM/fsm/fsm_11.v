
module fsm (
  input wire IN,
  input wire CLK,
  input wire RST,
  output reg MATCH
);

  reg [4:0] state;
  reg last_input;
  
  // Define states
  parameter S0 = 0;
  parameter S1 = 1;
  parameter S2 = 2;
  parameter S3 = 3;
  parameter S4 = 4;
  
  // Define state transitions based on inputs
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      state <= S0;
      MATCH <= 0;
    end else begin
      case (state)
        S0: if (IN) begin
              state <= S1;
              last_input <= IN;
            end
            else begin
              state <= S0;
              last_input <= IN;
            end
        S1: if (!IN) begin
              state <= S2;
              last_input <= IN;
            end
            else begin
              state <= S1;
              last_input <= IN;
            end
        S2: if (!IN) begin
              state <= S3;
              last_input <= IN;
            end
            else begin
              state <= S2;
              last_input <= IN;
            end
        S3: if (IN) begin
              state <= S4;
              last_input <= IN;
            end
            else begin
              state <= S3;
              last_input <= IN;
            end
        S4: if (IN) begin
              state <= S4;
              last_input <= IN;
            end
            else begin
              state <= S0;
              last_input <= IN;
            end
        default: state <= S0;
      endcase
    end
  end
  
  // Output logic
  always @(state, last_input) begin
    if (state == S1 || state == S3 || state == S4) begin
      MATCH <= (last_input == IN) ? 1 : 0;
    end else begin
      MATCH <= 0;
    end
  end

endmodule