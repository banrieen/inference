from autogen_core.models import UserMessage
from autogen_ext.models.ollama import OllamaChatCompletionClient
import asyncio 

async def main():
    """
    This function interacts with the Ollama model to answer a simple question.
    """

    # Initialize the OllamaChatCompletionClient to interact with the Ollama model.
    # The model "deepseek-r1:latest" is specified here.
    # This assumes your Ollama server is running locally on port 11434.
    ollama_model_client = OllamaChatCompletionClient(model="deepseek-r1:latest")

    response = await ollama_model_client.create([UserMessage(content="What is the capital of France?", source="user")])
    print(response)
    # Close the OllamaChatCompletionClient to release resources.
    await ollama_model_client.close()

if __name__ == "__main__":
    asyncio.run(main())