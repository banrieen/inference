import os

from autogen import ConversableAgent, UserProxyAgent
from llama_stack_client import LlamaStackClient
agent = ConversableAgent(
    "chatbot",
    llm_config={"config_list": [{"model": "llama3.1:latest", 
                                "base_url": "http://localhost:11434/v1",
                                "api_key": "ollama"}]},  # ollama serve
    code_execution_config=False,  # Turn off code execution, by default it is off.
    function_map=None,  # No registered functions, by default it is None.
    human_input_mode="NEVER",  # Never ask for human input.
)
reply = agent.generate_reply(messages=[{"content": "Tell me a joke.", "role": "user"}])
print(f"======>>{reply}")