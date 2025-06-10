from typing import List, Dict

class ResponseMerger:
    def __init__(self, weights):
        self.weights = weights
        
    def merge(self, responses: List[Dict]) -> str:
        scored = [self._score_response(r) for r in responses]
        return self._combine_responses(scored)
    
    def _score_response(self, response):
        scores = {
            'clarity': self._calculate_clarity(response['answer']),
            'accuracy': self._check_accuracy(response['answer']),
            # Add other metrics
        }
        return {**response, 'scores': scores}
    
    def _combine_responses(self, responses):
        # Implementation of fusion algorithm
        return "# Merged Answer\n\n" + "\n\n".join(
            f"## Best from {r['provider']}\n{r['answer']}" 
            for r in sorted(responses, key=lambda x: x['scores']['total'], reverse=True)[:2]
        )