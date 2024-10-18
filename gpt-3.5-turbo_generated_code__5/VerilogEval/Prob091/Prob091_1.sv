
module TopModule(
  input [5:0] y, 
  input w, 
  output reg Y1, 
  output reg Y3
);

  // Combinational logic for state output
  always @(y or w)
    case(y)
      6'b000001: // A
        begin
          if(w)
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
          else
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
        end
      
      6'b000010: // B
        begin
          if(w)
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
          else
            begin
              Y1 <= 1;
              Y3 <= 0;
            end
        end
      
      6'b000100: // C
        begin
          if(w)
            begin
              Y1 <= 1;
              Y3 <= 0;
            end
          else
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
        end
      
      6'b001000: // D
        begin
          if(w)
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
          else
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
        end
      
      6'b010000: // E
        begin
          if(w)
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
          else
            begin
              Y1 <= 0;
              Y3 <= 1;
            end
        end
      
      6'b100000: // F
        begin
          if(w)
            begin
              Y1 <= 0;
              Y3 <= 1;
            end
          else
            begin
              Y1 <= 0;
              Y3 <= 0;
            end
        end
      
      default:
        begin
          Y1 <= 0;
          Y3 <= 0;
        end
    endcase

endmodule