
module TopModule (
    input clk,
    input reset,
    output reg shift_ena
);

// State to count the number of clock cycles 
reg [1:0] cycle_count;

// Sequential logic for managing the shift enable signal
always @(posedge clk) begin
    if (reset) begin
        shift_ena <= 1'b1; // Enable shift register
        cycle_count <= 2'b00; // Reset the counter
    end else if (cycle_count < 2'b11) begin
        cycle_count <= cycle_count + 2'b01; // Increment the cycle counter
        shift_ena <= 1'b1; // Continue enabling for the first 4 cycles
    end else begin
        shift_ena <= 1'b0; // Disable shift register after 4 cycles
    end
end

endmodule