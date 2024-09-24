module TopModule (
	input clk,
	input aresetn,
	input x,
	output z
);
    reg [31:0] codes;
    reg [15:0] code;
    always @ (posedge clk or negedge aresetn) begin
        if(~aresetn) begin
            code <= 0;
        end
        else begin
            case(code)
                101: begin
                    code <= 4'hF;
                    codes <= 4'hF;
                end
                101: begin
                    code <= 4'h2;
                    codes <= 4'h2;
                end
                default: begin
                    code <= 4'hF;
                    codes <= 4'h0;
                end
            endcase
        end
    end
    assign z = codes[31];
endmodule

