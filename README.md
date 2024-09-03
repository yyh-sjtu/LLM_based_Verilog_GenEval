<div style="text-align: center;">
    <h1>LLM_based_Verilog_GenEval: A comprehensive generation and evaluation framework for LLM based Verilog code generation</h1>
</div>

<div style="text-align: right;">
    <div style="display: inline-block; text-align: left;">
        <span>Author: Yunhao Zhou</span></br>
        <span>Date: 2024-09-03</span>
    </div>
</div>

## 1. Introduction
This framework integrates three mainstream benchmarks, including RTLLM, VGen, VerilogEval for LLM based verilog generation.

## 2. Usage
### 1. Install iverilog:
```bash
sudo apt install iverilog
```
### 2. Run

Run the following command to evaluate on all benchmarks:
```bash
python src/verilog_gen_eval.py --benchmark all
```
Run the following command to evaluate on a specific benchmark:
```bash
python src/verilog_gen_eval.py --benchmark RTLLM
```