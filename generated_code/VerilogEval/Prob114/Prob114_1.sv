
module TopModule (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

always @(*) begin
    case(code)
        8'h45: begin
            out <= 4'b0;
            valid <= 1;
        end
        8'h16: begin
            out <= 4'b1;
            valid <= 1;
        end
        8'h1e: begin
            out <= 4'b2;
            valid <= 1;
        end
        8'h26: begin
            out <= 4'b3;
            valid <= 1;
        end
        8'h25: begin
            out <= 4'b4;
            valid <= 1;
        end
        8'h2e: begin
            out <= 4'b5;
            valid <= 1;
        end
        8'h36: begin
            out <= 4'b6;
            valid <= 1;
        end
        8'h3d: begin
            out <= 4'b7;
            valid <= 1;
        end
        8'h3e: begin
            out <= 4'b8;
            valid <= 1;
        end
        8'h46: begin
            out <= 4'b9;
            valid <= 1;
        end
        default: begin
            out <= 4'b0;
            valid <= 0;
        end
    endcase
end

endmodule