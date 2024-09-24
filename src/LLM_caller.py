'''
LLM_caller module
2024-09-04
Author: Yunhao Zhou
'''

# from openai import OpenAI
import openai
import local_model

local_model_list = ["codet5_200m"]

def llm_call(prompt, args):
    model_name = args.model_name
    model_path = args.model_path
    api_key = args.api_key
    base_url = args.base_url

    if model_name == "gpt-4" or model_name == "gpt-3.5-turbo":
        if api_key == None or base_url == None:
            raise ValueError("no api_key for openai model")
        client = openai.OpenAI(api_key=api_key, base_url=base_url)

        if model_name == "gpt-4":
            # need to create the prompt for gpt-4
            response = client.chat.completions.create(
                model=model_name,
                messages=[
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt}
                        ],
                    }
                ],
                max_tokens=3000
            )
        elif model_name == "gpt-3.5-turbo":
            response = client.chat.completions.create(
                model = model_name,
                messages=[
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt}
                        ],
                    }
                ],
                max_tokens=3000,
            )
        else :
            raise ValueError("model_name should be gpt-4 or gpt-3.5-turbo")

        answer = response.choices[0].message.content
    elif model_name in local_model_list:
        global local_model_instance
        try:
            local_model_instance
            # print("model has been instantiated")
        except:
            # print("model is not instantiated, start instantiating")
            local_model_instance = local_model.codet5(model=model_path, 
                                                      temperature=args.temperature,
                                                      N=args.N,
                                                      max_len=args.max_len,
                                                      tokenizer=args.tokenizer,
                                                      num_seqs_per_iter=args.num_seqs_per_iter,
                                                      num_beams=args.num_beams)
        try:
            answer = local_model_instance.completion_create(prompt)
        except Exception as e:
            print("Error occurs when calling local model")
            print(e)
    else:
        raise ValueError("Invalid model name")


    return answer

if __name__ == "__main__":
    
    # model_name = "gpt-4"
    # # model_name = "gpt-4"
    # prompt = """
    # Generate a adder_8bit module.

    # Module name:  
    #     adder_8bit               
    # Input ports：
    #     input [7:0] a, b,
    #     input cin
    # Output ports：
    #     output [7:0] sum,
    #     output SUM,
    #     output cout
    # """
    
    # output = llm_call(model_name, prompt)
    
    # print(output)
    model_name = 'codet5_200m'
    prompt = """
    Generate a adder_8bit module.

    Module name:  
        adder_8bit               
    Input ports:
        input [7:0] a, b,
        input cin
    Output ports:
        output [7:0] sum,
        output SUM,
        output cout
    # """
    for i in range(10):
        print(f"Call{i}:")
        print(llm_call(model_name=model_name, prompt=prompt))