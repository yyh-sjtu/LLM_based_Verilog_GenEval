benchmark_list = [
    "RTLLM",
    "VGen",
    "VerilogEval",
    "VerilogEval_Human",
    "VerilogEval_Machine",
    "RTLLM_v1.1"
]

file_patterns = {
    "RTLLM": {"prompt_pattern": "design_description.txt",
                "testbench_pattern": "testbench.v"},
    "VGen": {"prompt_pattern": "prompt*", 
                "testbench_pattern": "tb_*"},
    "VerilogEval": {"prompt_pattern": "*prompt.txt", 
                    "testbench_pattern": "*test.sv"},
    "VerilogEval_Human": {"prompt_pattern": "description.txt", 
                            "testbench_pattern": "testbench.sv"},
    "VerilogEval_Machine": {"prompt_pattern": "description.txt", 
                            "testbench_pattern": "testbench.sv"},
    "RTLLM_v1.1": {"prompt_pattern": "design_description.txt",
                "testbench_pattern": "testbench.v"}
}

top_instruction = {
    "RTLLM": "",
    "VGen": "Please act as a professional verilog designer. \n Implement the following module.\n",
    "VerilogEval": "Please act as a professional RTL designer.\n",
    "VerilogEval_Human": "",
    "VerilogEval_Machine": "",
    "RTLLM_v1.1": ""
}