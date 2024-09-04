'''
Module for evaluation of Verilog Syntax and function.
2024-09-04
Author: Yunhao Zhou
'''

import os
import subprocess
from glob import glob

def evaluate(benchmark, design_file, testbench, temp_outputfile):
    
    def is_correct(benchmark, result):
        result = result.lower()
        if benchmark == "RTLLM":
            return True if 'pass' in result else False
        elif benchmark == "VGen":
            return True if 'pass' in result else False
        elif benchmark == "VerilogEval":
            return True if 'has no mismatches' in result else False
        else:
            print("unknown_benchmark")
            return False
    
    # Create the command to compile and run with iverilog
    try:
        # Run the command
        if benchmark == "VerilogEval":
            ref_file = glob(os.path.join(os.path.dirname(testbench), "*ref.sv"))[0]
            cmd = f"iverilog -g2005-sv -o {temp_outputfile} {testbench} {ref_file} {design_file} && vvp {temp_outputfile}"
        else:
            cmd = f"iverilog -o {temp_outputfile} {testbench} {design_file} && vvp {temp_outputfile}"
            
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=2,  start_new_session=True)
        if is_correct(benchmark, result.stdout):
            return True 
        else:
            return False
    except Exception as e:
        print(f"Error running test: {e}")
    return False
