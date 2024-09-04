'''
LLM_caller module
2024-09-04
Author: Yunhao Zhou
'''

# from openai import OpenAI
import openai

def llm_call(model_name, prompt, api_key, base_url):
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

    return answer

if __name__ == "__main__":
    
    model_name = "gpt-4"
    # model_name = "gpt-4"
    prompt = """
    Generate a adder_8bit module.

    Module name:  
        adder_8bit               
    Input ports：
        input [7:0] a, b,
        input cin
    Output ports：
        output [7:0] sum,
        output SUM,
        output cout
    """
    
    output = llm_call(model_name, prompt)
    
    print(output)