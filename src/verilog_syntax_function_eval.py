'''
Module for evaluation of Verilog Syntax and function.
2024-09-04
Author: Yunhao Zhou
'''

import os
import subprocess

def evaluate(benchmark, design_file, testbench, temp_outputfile):
    
    def is_correct(benchmark, result):
        result = result.lower()
        if benchmark == "RTLLM":
            return True if 'pass' in result else False
        elif benchmark == "VGen":
            return True if 'pass' in result else False
        elif benchmark == "VerilogEval":
            return True
        else:
            print("unknown_benchmark")
            return False
    
    # Create the command to compile and run with iverilog
    try:
        # Run the command
        cmd = f"iverilog -o {temp_outputfile} {testbench} {design_file} && vvp {temp_outputfile}"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=2,  start_new_session=True)
        # Check if the test passed
        if is_correct(benchmark, result.stdout):
            return True
    except Exception as e:
        print(f"Error running test: {e}")
    return False

