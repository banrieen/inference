from openai import OpenAI
from typing import Dict, Any
import httpx
import json

class LLMAdapter:
    def __init__(self, config):
        self.clients = {
            'deepseek': OpenAI(api_key=config['deepseek']),
            'hunyuan': httpx.AsyncClient(base_url="https://hunyuan.tencent.com/api"),
            # Add other providers
        }

    async def query(self, provider: str, question: str) -> Dict[str, Any]:
        if provider == 'deepseek':
            return await self._query_deepseek(question)
        # Implement other providers
        
    async def _query_deepseek(self, question: str):
        response = self.clients['deepseek'].chat.completions.create(
            model="deepseek-r1",
            messages=[{"role": "user", "content": question}]
        )
        return {
            'provider': 'deepseek',
            'answer': response.choices[0].message.content,
            'metadata': response.usage.dict()
        }