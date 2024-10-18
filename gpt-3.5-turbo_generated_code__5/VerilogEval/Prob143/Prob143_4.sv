
module TopModule(
  input in,
  input [9:0] state,
  output reg [9:0] next_state,
  output reg out1,
  output reg out2
);

  always @(*)
  begin
    case(state)
      10'b0000000001: // S1
        begin
          if(in == 1)
            begin
              next_state = 10'b0000000010; // S2
              out1 = 0;
              out2 = 0;
            end
          else
            begin
              next_state = 10'b0000000001; // S1 
              out1 = 0;
              out2 = 0;
            end
        end
      
      10'b0000000010: // S2
        begin
          if(in == 1)
            begin
              next_state = 10'b0000000011; // S3
              out1 = 0;
              out2 = 0;
            end
          else
            begin
              next_state = 10'b0000000001; // S1 
              out1 = 0;
              out2 = 0;
            end
        end
      
      10'b0000000011: // S3
        begin
          if(in == 1)
            begin
              next_state = 10'b0000000100; // S4
              out1 = 0;
              out2 = 0;
            end
          else
            begin
              next_state = 10'b0000000001; // S1 
              out1 = 0;
              out2 = 0;
            end
        end
      
      10'b0000000100: // S4
        begin
          if(in == 1)
            begin
              next_state = 10'b0000000101; // S5
              out1 = 0;
              out2 = 0;
            end
          else
            begin
              next_state = 10'b0000000001; // S1 
              out1 = 0;
              out2 = 0;
            end
        end

      // Remaining states and outputs can be implemented in a similar manner as above

      default:
        begin
          next_state = 10'b0000000001; // S1
          out1 = 0;
          out2 = 0;
        end
    endcase
  end

endmodule