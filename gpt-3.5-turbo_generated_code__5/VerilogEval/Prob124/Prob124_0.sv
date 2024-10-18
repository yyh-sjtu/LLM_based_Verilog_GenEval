
module TopModule(
    input  clk,
    input  load,
    input  data [511:0],
    output reg q [511:0]
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (int i = 1; i < 511; i = i+1) begin
            q[i] <= getNextState(q[i-1], q[i], q[i+1]);
        end
    end
end

function getNextState;
    input left, center, right;
    begin
        case ({left, center, right})
            3'b111: return 1'b0;
            3'b110: return 1'b1;
            3'b101: return 1'b1;
            3'b100: return 1'b0;
            3'b011: return 1'b1;
            3'b010: return 1'b1;
            3'b001: return 1'b1;
            3'b000: return 1'b0;
            default: return 1'b0;
        endcase
    end
endfunction

endmodule