module TopModule (
	input [255:0] in,
	input [7:0] sel,
	output out
);
    parameter AWIDTH = 8;
    parameter BWIDTH = 8;
    parameter AWIDTH = 8;
    parameter BWIDTH = 8;
    reg [AWIDTH-1:0] out_reg;
    always @ (sel or in) begin
        case (sel)
            AWIDTH:
                out_reg = in[AWIDTH-1:0];
            BWIDTH:
                out_reg = in[BWIDTH-1:0];
            default:
                out_reg = 256'bx;
        endcase
    end
    assign out = out_reg;
endmodule

