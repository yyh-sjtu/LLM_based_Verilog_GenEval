
module TopModule (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        // Default assignment to avoid latch inference
        shut_off_computer = 0; // Default value 
      
        if (cpu_overheated)
            shut_off_computer = 1; // Set to 1 only if cpu_overheated is true   
    end

    always @(*) begin
        // Default assignment to avoid latch inference
        keep_driving = 1; // Default value 

        if (~arrived)
            keep_driving = ~gas_tank_empty; // Set keep_driving based on gas_tank_empty only if not arrived
    end

endmodule