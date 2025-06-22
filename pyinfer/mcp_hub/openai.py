import openai

class DeepSeekR1:
    def __init__(self, api_key):
        self.api_key = api_key
        openai.api_key = api_key   # '5e2598e4-0169-4fd8-82a7-af10dbd7a3db'
        base_url = 'https://api-inference.modelscope.cn/v1/',

    def ask_question(self, question):
        response = openai.Completion.create(
            engine="deepseek-r1",
            prompt=question,
            max_tokens=150
        )
        return response.choices[0].text