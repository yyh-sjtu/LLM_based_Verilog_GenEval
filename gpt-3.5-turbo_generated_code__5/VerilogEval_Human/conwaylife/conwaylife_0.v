
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

reg [255:0] next_q;
reg [255:0] temp_q;

always @(posedge clk) begin
    if(load) begin
        q <= data;
    end else begin
        for(int i=0; i<16; i=i+1) begin
            for(int j=0; j<16; j=j+1) begin
                int alive_neighbors = 0;
                if(q[((i+15)%16)*16 + ((j+1)%16)]) alive_neighbors = alive_neighbors + 1;
                if(q[((i+15)%16)*16 + ((j+15)%16)]) alive_neighbors = alive_neighbors + 1;
                if(q[((i+15)%16)*16 + j]) alive_neighbors = alive_neighbors + 1;
                if(q[(i*16) + ((j+1)%16)]) alive_neighbors = alive_neighbors + 1;
                if(q[(i*16) + ((j+15)%16)]) alive_neighbors = alive_neighbors + 1;
                if(q[((i+1)%16)*16 + ((j+1)%16)]) alive_neighbors = alive_neighbors + 1;
                if(q[((i+1)%16)*16 + ((j+15)%16)]) alive_neighbors = alive_neighbors + 1;
                if(q[((i+1)%16)*16 + j]) alive_neighbors = alive_neighbors + 1;
                
                if(alive_neighbors >= 4 || alive_neighbors <= 1) begin
                    next_q[i*16 + j] = 0;
                end else if(alive_neighbors == 2) begin
                    next_q[i*16 + j] = q[i*16 + j];
                end else if(alive_neighbors == 3) begin
                    next_q[i*16 + j] = 1;
                end
            end
        end
        q <= next_q;
    end
end

endmodule