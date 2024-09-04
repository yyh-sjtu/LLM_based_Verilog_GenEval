
module TopModule (
    input  wire ring,          // Input signal indicating an incoming call
    input  wire vibrate_mode,  // Input signal indicating the vibrate mode is active
    output wire ringer,        // Output signal to control the ringer
    output wire motor          // Output signal to control the vibration motor
);

    // Assign outputs based on ring and vibrate_mode inputs
    assign ringer = ring && ~vibrate_mode; // Ringer is on if there's a ring and vibrate_mode is off
    assign motor  = ring && vibrate_mode;   // Motor is on if there's a ring and vibrate_mode is on

endmodule