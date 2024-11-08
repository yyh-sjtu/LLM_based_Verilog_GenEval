'''
Code extractor
2024-09-04
Author: Yunhao Zhou
'''

import re

def verilog_extractor(text): 
    
    begin = text.find("```verilog\n")
    end = text.find("\n```")
    verilog = ""
    endmodule_count = text.count("endmodule")
    
    while begin != -1 and end != -1:
        verilog += text[begin + 10:end]
        begin = text.find("```verilog\n", end)
        end = text.find("\n```", begin)
        
    if not "module" in verilog:
        pattern = r'module\s+[^\(\s]+\s*(?:#\s*\(.*?\))?\s*\(.*?\)\s*;\s*?(?:(?!module\s).)*?\bendmodule'
        verilog_code_extracted = re.findall(pattern, text, re.DOTALL)
        for module in verilog_code_extracted:
            verilog += (module + '\n\n')
            
    # if not "module" in verilog:
    #     pattern = r'module\s+[^\(\s]+\s*(?:#\s*\(.*\)){0,1}\s*\(.*?\);.*?endmodule'
    #     verilog_code_extracted = re.findall(pattern, text, re.DOTALL)
    #     for module in verilog_code_extracted:
    #         verilog += (module + '\n\n')
    
    if endmodule_count > len(verilog_code_extracted):
        print("Warning: Risk of missing some modules while extracting Verilog code.")
            
    return verilog

if __name__ == "__main__":
#     text = """
# ```
# Below is an instruction that describes a task, paired with an input that provides further context. 
# Write a response that appropriately completes the request.


# ### Instruction:
# Based on the prompt, output the verilog code.

# ### Input:
# Please act as a professional verilog designer.

# Implement a module of perpetual calendar. The starting value of Secs, Mins, and Hours are all 0. Both Secs and Mins loop continuously from 0 to 59. When Secs=59, Min increases by 1 at the next cycle, and when Min=59 && Secs=59, Hours increases by 1 at the next cycle. Hours is counted from the 0-23 cycle.

# Module name:  
#     calendar  
                 
# Input ports:
#     CLK: Clock input
#     RST: Active high reset signal

# Output ports:
#     Hours: 6-bit output representing the current hours
#     Mins: 6-bit output representing the current minutes
#     Secs: 6-bit output representing the current seconds

# Implementation:
# module()
# The calendar module uses three always blocks to update the values of seconds, minutes, and hours based on the clock signal and reset signal.
# The first always block triggers on the positive edge of the clock signal (posedge CLK) or the positive edge of the reset signal (posedge RST). It checks if the reset signal is active (RST) and sets the seconds value (Secs) to 0. If the seconds value is 59, it wraps around and sets the seconds value to 0. Otherwise, it increments the seconds value by 1.
# The second always block also triggers on the positive edge of the clock signal or the positive edge of the reset signal. It handles the minutes value (Mins). If the reset signal is active, it sets the minutes value to 0. If both the minutes and seconds values are 59, it wraps around and sets the minutes value to 0. If the seconds value is 59, it increments the minutes value by 1. Otherwise, it keeps the minutes value unchanged.
# The third always block triggers on the positive edge of the clock signal or the positive edge of the reset signal. It handles the hours value (Hours). If the reset signal is active, it sets the hours value to 0. If the hours, minutes, and seconds values are all at their maximum (23, 59, and 59 respectively), it wraps around and sets the hours value to 0. If the minutes and seconds values are both 59, it increments the hours value by 1. Otherwise, it keeps the hours value unchanged.

# Give me the complete code.


# ### Response:`timescale 1ns/1ns
# module    calendar    (
#     CLK,
#     RST,
#     Hours,
#     Mins,
#     Secs
# ) ;
# # (para
# )
#     input    CLK;
#     input    RST;
#     output    [5:0]    Hours;
#     output    [5:0]    Mins;
#     output    [5:0]    Secs;
#     reg        [5:0]    Secs;
#     reg        [5:0]    Mins;
#     reg        [5:0]    Hours;
#     always@(posedge CLK)
#         if(RST)
#             Secs <= 6'b0;
#         else if(Secs == 6'b59)
#             Secs <= 6'b0;
#         else
#             Secs <= Secs + 1'b1;
#     always@(posedge CLK)
#         if(RST)
#             Mins <= 6'b0;
#         else if(Mins == 6'b59)
#             Mins <= 6'b0;
#         else if(Secs == 6'b59)
#             Mins <= Mins + 1'b1;
#     always@(posedge CLK)
#         if(RST)
#             Hours <= 6'b0;
#         else if(Hours == 6'b23)
#             Hours <= 6'b0;
#         else if(Mins == 6'b59)
#             Hours <= Hours + 1'b1;
# endmodule
# ```
#     """
    text = """
    module count_slow ( input clk, input slowena, input reset, output reg [ 3 :0] q) ;
    always @( posedge clk ) begin
    if ( reset ) begin
    q < = 4'b0;
    end else if ( slowena ) begin
    q < = q + 1;
    end
    end
    endmodule
    """

    print(verilog_extractor(text))