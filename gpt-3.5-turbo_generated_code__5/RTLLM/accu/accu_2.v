
module accu (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire valid_in,
    output wire valid_out,
    output wire [9:0] data_out
);
    
    reg [9:0] accumulator;
    reg [2:0] count;
    reg valid_out_next;
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            accumulator <= 0;
        else if (valid_in) begin
            accumulator <= accumulator + data_in;
            
            if (count == 2)
                valid_out_next <= 1;
            else
                valid_out_next <= 0;
                
            count <= count + 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            count <= 0;
        else if (valid_in && count == 3)
            count <= 0;
    end
    
    assign valid_out = valid_out_next;
    assign data_out = accumulator;
        
endmodule