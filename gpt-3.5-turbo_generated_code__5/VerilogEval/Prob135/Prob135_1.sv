
module TopModule(
    input [2:0] y,
    input w,
    output Y1
);
    reg [2:0] nextState;
    
    always @(y, w)
    begin
        case (y)
            3'b000:
                begin
                    if (w)
                        nextState = 3'b000;
                    else
                        nextState = 3'b001;
                end
                
            3'b001:
                begin
                    if (w)
                        nextState = 3'b010;
                    else
                        nextState = 3'b011;
                end
                
            3'b010:
                begin
                    if (w)
                        nextState = 3'b100;
                    else
                        nextState = 3'b011;
                end
                
            3'b011:
                begin
                    if (w)
                        nextState = 3'b001;
                    else
                        nextState = 3'b101;
                end
                
            3'b100:
                begin
                    if (w)
                        nextState = 3'b100;
                    else
                        nextState = 3'b101;
                end
                
            3'b101:
                begin
                    if (w)
                        nextState = 3'b010;
                    else
                        nextState = 3'b101;
                end
                
            default:
                nextState = 3'b000;
        endcase
    end
    
    assign Y1 = nextState[1];
    
endmodule