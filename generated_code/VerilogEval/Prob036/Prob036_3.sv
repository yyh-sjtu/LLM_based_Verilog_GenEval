
module TopModule (
    input wire ring,
    input wire vibrate_mode,
    output reg ringer,
    output reg motor
);

// Always block that triggers on changes to inputs
always @(*) begin
    // Initialize outputs to 0
    ringer = 0;
    motor = 0;
    
    // Control logic for ringer and motor
    if (ring) begin
        if (vibrate_mode) begin
            motor = 1;  // Activate motor in vibrate mode
        end else begin
            ringer = 1; // Activate ringer when not in vibrate mode
        end
    end
end

endmodule