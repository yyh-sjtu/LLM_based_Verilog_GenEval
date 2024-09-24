module TopModule (
	input clk,
	input reset,
	input [7:0] in,
	output [23:0] out_bytes,
	output done
);
    reg [23:0] msg;
    reg [23:0] msg_bytes;
    reg done;
    always @(posedge clk) begin
        if (reset) begin
            msg <= 24'h0;
            msg_bytes <= 24'h0;
        end else begin
            if (in[3]) begin
                msg <= msg_bytes[23:16];
                msg_bytes <= msg_bytes[15:8];
            end
            if (in[3]) begin
                msg <= msg_bytes[23:16];
            end
            if (in[3]) begin
                msg_bytes <= msg_bytes[23:16];
            end
        end
    end
    assign done = (msg == 24'h0);
endmodule

