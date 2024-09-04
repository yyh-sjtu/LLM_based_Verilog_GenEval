
module TopModule (
    input  wire clk,
    input  wire reset,
    input  wire ena,
    output reg  pm,
    output reg  [7:0] hh,
    output reg  [7:0] mm,
    output reg  [7:0] ss
);

// State variables
reg [3:0] sec_count; // seconds in BCD (00-59)
reg [3:0] min_count; // minutes in BCD (00-59)
reg [3:0] hour_count; // hours in BCD (01-12)
reg     is_pm; // Flag for AM/PM

// States
localparam RESET_HH = 4'd0;
localparam RESET_MN = 4'd0;
localparam RESET_SC = 4'd0;

// Always block to handle reset and enable functionality
always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        hh <= 8'h30; // '12' in BCD = 00110000 (ASCII for '12')
        mm <= 8'h00; // '00' in BCD
        ss <= 8'h00; // '00' in BCD
        is_pm <= 1'b0; // Set to AM
        pm <= 1'b0; // PM status
        sec_count <= 4'b0000;
        min_count <= 4'b0000;
        hour_count <= 4'b0000; // 12:00 in BCD
    end else if (ena) begin
        // Increment the clock
        if (sec_count == 4'd59) begin
            sec_count <= 4'b0000; // Reset seconds
            if (min_count == 4'd59) begin // Check minutes
                min_count <= 4'b0000; // Reset minutes
                // Increment hours
                if (hour_count == 4'd12) begin
                    hour_count <= 4'd1; // Reset to 1 after 12
                    is_pm <= ~is_pm; // Toggle AM/PM
                end else begin
                    hour_count <= hour_count + 1; // Increment hours
                end
            end else begin
                min_count <= min_count + 1; // Increment minutes
            end
        end else begin
            sec_count <= sec_count + 1; // Increment seconds
        end
    end
    
    // Update outputs
    pm <= is_pm;
    // Convert hour, min, sec to BCD
    hh <= {4'h0, hour_count}; // Upper four bits are zeros
    mm <= {4'h0, min_count}; // Upper four bits are zeros
    ss <= {4'h0, sec_count}; // Upper four bits are zeros
end

endmodule