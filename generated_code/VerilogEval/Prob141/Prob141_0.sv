
module TopModule (
    input wire clk,
    input wire reset,
    input wire ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // Define BCD counter limits
    localparam MAX_HH = 8'd12;  // 12 hours in BCD
    localparam MAX_MM_SS = 8'd59; // 59 minutes and seconds in BCD 

    reg [1:0] am_pm_state; // 0 for AM, 1 for PM

    // BCD increment function
    function [7:0] bcd_increment(input [7:0] bcd_value, input [7:0] max_value);
        begin
            if (bcd_value == max_value) begin
                bcd_increment = 8'd0; // Reset when it reaches max
            end else if (bcd_value[3:0] == 4'd9) begin
                bcd_increment = {bcd_value[7:4] + 1'b1, 4'd0}; // Increase upper nibble
            end else begin
                bcd_increment = bcd_value + 1'b1; // Normal increment
            end
        end
    endfunction

    // Clock process
    always @(posedge clk) begin
        if (reset) begin
            // Reset the time to 12:00 AM
            hh <= 8'd1;  // BCD for hour 12
            mm <= 8'd0;  // BCD for minutes 00
            ss <= 8'd0;  // BCD for seconds 00
            pm <= 1'b0;  // AM
            am_pm_state <= 2'd0; // Initial state: AM
        end else if (ena) begin
            // Update seconds
            ss <= bcd_increment(ss, MAX_MM_SS);
            
            if (ss == 8'd0) begin // A second has passed
                // Update minutes
                mm <= bcd_increment(mm, MAX_MM_SS);

                if (mm == 8'd0) begin // A minute has passed
                    // Update hours
                    if (hh == MAX_HH) begin
                        am_pm_state <= ~am_pm_state; // Toggle AM/PM
                    end
                    hh <= bcd_increment(hh, MAX_HH);
                end
            end
        end
    end

    // Keeping the AM/PM signal updated
    always @* begin
        pm = am_pm_state[0]; // PM if am_pm_state is 1
    end

endmodule