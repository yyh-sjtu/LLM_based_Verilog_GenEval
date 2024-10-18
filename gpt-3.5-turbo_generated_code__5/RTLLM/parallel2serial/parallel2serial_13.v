
module parallel2serial(
    input wire clk,
    input wire rst_n,
    input wire [3:0] d,
    output wire valid_out,
    output wire dout
);

    reg [2:0] cnt;      // Counter register
    reg [3:0] data;     // Data register

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 0;   // Reset counter
            data <= 0;  // Reset data register
            valid_out <= 0;
            dout <= 0;
        end
        else begin
            if(cnt == 3) begin
                data <= d;      // Update data register with parallel input
                cnt <= 0;       // Reset counter
                valid_out <= 1; // Set valid signal to indicate availability of serial output
                dout <= data[3]; // Serial output is the most significant bit of data
            end
            else begin
                cnt <= cnt + 1; // Increment counter
                valid_out <= 0; // Reset valid signal
                data <= {data[2:0], 1'b0}; // Shift data register one bit to the left
                dout <= data[3]; // Serial output is the most significant bit of data
            end
        end
    end

endmodule