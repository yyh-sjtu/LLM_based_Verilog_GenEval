
module TopModule (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

reg [15:0] reg_array [0:15];

always @(posedge clk) begin
    if (resetn == 0) begin
        for (int i = 0; i < 16; i++) begin
            reg_array[i] <= 16'h0;
        end
    end else begin
        for (int i = 0; i < 16; i++) begin
            if (byteena[0] == 1) begin
                reg_array[i][7:0] <= d[7:0];
            end
            if (byteena[1] == 1) begin
                reg_array[i][15:8] <= d[15:8];
            end
        end
    end
end

always @(posedge clk) begin
    if (resetn == 0) begin
        q <= 16'h0;
    end else begin
        q <= {reg_array[15],reg_array[14],reg_array[13],reg_array[12],
              reg_array[11],reg_array[10],reg_array[9],reg_array[8],
              reg_array[7],reg_array[6],reg_array[5],reg_array[4],
              reg_array[3],reg_array[2],reg_array[1],reg_array[0]};
    end
end

endmodule