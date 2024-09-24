
module TopModule (
    input [6:0] y,
    input w,
    output Y1,
    output Y3
);

// State encoding
parameter A = 7'b0000001;
parameter B = 7'b0000010;
parameter C = 7'b0000100;
parameter D = 7'b0001000;
parameter E = 7'b0010000;
parameter F = 7'b0100000;

// State machine logic
always @(*) begin
    case (y)
        A: begin
            Y1 = 1'b0;
            if (w)
                Y3 = 1'b0;
            else
                Y3 = 1'b1;
        end
        B: begin
            Y1 = 1'b0;
            if (w)
                Y3 = 1'b1;
            else
                Y3 = 1'b0;
        end
        C: begin
            Y1 = 1'b1;
            if (w)
                Y3 = 1'b0;
            else
                Y3 = 1'b1;
        end
        D: begin
            Y1 = 1'b1;
            if (w)
                Y3 = 1'b1;
            else
                Y3 = 1'b0;
        end
        E: begin
            Y1 = 1'b0;
            if (w)
                Y3 = 1'b1;
            else
                Y3 = 1'b0;
        end
        F: begin
            Y1 = 1'b1;
            if (w)
                Y3 = 1'b0;
            else
                Y3 = 1'b1;
        end
        default: begin
            Y1 = 1'b0;
            Y3 = 1'b0;
        end
    endcase
end

endmodule