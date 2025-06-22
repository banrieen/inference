import requests

def searxng_search(query: str, instance_url="https://cn.bing.com/search?"):
    params = {
        "q": query,
        "format": "json",
        "pageno": 1
    }
    try:
        response = requests.get(f"{instance_url}/search", params=params)
        response.raise_for_status()
        return response.json()["results"]
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return []

# Usage
results = searxng_search("open source search engines")
for result in results[:3]:
    print(f"Title: {result['title']}\nURL: {result['url']}\n---")