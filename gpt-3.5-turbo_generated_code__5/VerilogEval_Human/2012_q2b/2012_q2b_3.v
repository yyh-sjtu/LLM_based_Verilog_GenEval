module state_machine (
    input clk,
    input reset,
    output reg [5:0] y,
    
);

parameter A = 6'b000001;
parameter B = 6'b000010;
parameter C = 6'b000100;
parameter D = 6'b001000;
parameter E = 6'b010000;
parameter F = 6'b100000;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        y <= A;
    end else begin
        case (y)
            A: begin
                if (w) begin
                    y <= B;
                else
                    y <= A;
                end
            end
            B: begin
                if (w) begin
                    y <= C;
                else
                    y <= D;
                end
            end
            C: begin
                if (w) begin
                    y <= E;
                else
                    y <= D;
                end
            end
            D: begin
                if (w) begin
                    y <= F;
                else
                    y <= A;
                end
            end
            E: begin
                if (w) begin
                    y <= E;
                else
                    y <= D;
                end
            end
            F: begin
                if (w) begin
                    y <= C;
                else
                    y <= D;
                end
            end
        endcase
    end
end

assign Y1 = y[1];
assign Y3 = y[3];

endmodule

