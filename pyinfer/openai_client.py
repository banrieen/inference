from autogen_ext.models.openai import OpenAIChatCompletionClient
from autogen_core.models import UserMessage
import asyncio 

model_info = {
    "api_type": "openai",
    'vision': False,
    'function_calling': True,
    "json_output": True,
    "family": "deepseek",
}

async def main():
    openai_model_client = OpenAIChatCompletionClient(
        model="deepseek-ai/DeepSeek-R1-0528",
        base_url='https://api-inference.modelscope.cn/v1/',
        api_key='25bd76e1-8a58-4c45-ba65-4bf097a5cc67', 
        model_info=model_info, 
    )

    result = await openai_model_client.create([UserMessage(content="What is the capital of France?", source="user")])
    print(result)
    await openai_model_client.close()

if __name__ == "__main__":
    asyncio.run(main())