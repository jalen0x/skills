# API Patterns for E-commerce Scrapers

## Table of Contents
- [GraphQL API](#graphql-api)
- [REST API (HTML Response)](#rest-api-html-response)
- [REST API (JSON Response)](#rest-api-json-response)
- [Pagination Patterns](#pagination-patterns)

## GraphQL API

Example: Galaxus.fr

```python
def make_request(self, variables, after=None):
    payload = {
        "variables": {
            "filters": [...],
            "first": 100,
            "sortOrder": "RELEVANCE",
            **variables
        }
    }
    if after:
        payload["variables"]["after"] = after

    response = requests.post(self.url, headers=self.headers, json=payload, timeout=30)
    return response.json()
```

**Key patterns:**
- Use POST with JSON payload
- Pagination via `after` cursor from `pageInfo.endCursor`
- Check `pageInfo.hasNextPage` for continuation
- IDs often base64-encoded: `base64.b64encode(f"Tag\ni{id}".encode()).decode()`

## REST API (HTML Response)

Example: Nature & Découvertes

```python
def fetch_page(self, rayon_id: int, page_num: int) -> str:
    params = {
        'numPage': page_num,
        'rayonId': rayon_id,
        # ... other params
    }
    response = requests.get(self.api_url, params=params, headers=self.headers, timeout=30)
    return response.text

def parse_product_urls(self, html: str) -> List[str]:
    tree = etree.HTML(html)
    links = tree.xpath('//div[contains(@class, "product")]//a[@href]')
    return [self.base_url + link.get('href') for link in links if link.get('href').startswith('/')]
```

**Key patterns:**
- Use GET with query parameters
- Parse HTML with `lxml.etree`
- Use XPath to extract product links
- Look for hidden inputs for pagination info: `//input[@id="hidNombreResultatsInt"]/@value`

## REST API (JSON Response)

Example: Demandware platform (EMP Online)

```python
def fetch_page(self, cgid: str, page: int) -> dict:
    params = {
        'cgid': cgid,
        'deferredPage': page,
        'start': page * self.page_size,
        'sz': self.page_size
    }
    response = requests.get(self.api_url, params=params, headers=self.headers, timeout=30)
    return response.json()
```

**Key patterns:**
- Category ID (`cgid`) often in URL path: `/category-name-123` → `123`
- Pagination via `start` offset or `page` number
- Empty response indicates end of data

## Pagination Patterns

### Cursor-based (GraphQL)
```python
after = None
while True:
    data = self.make_request(after=after)
    page_info = data["data"]["products"]["pageInfo"]
    if not page_info["hasNextPage"]:
        break
    after = page_info["endCursor"]
```

### Page number
```python
page = 1
consecutive_empty = 0
while consecutive_empty < 2:
    urls = self.fetch_page(page)
    if not urls:
        consecutive_empty += 1
    else:
        consecutive_empty = 0
    page += 1
```

### Offset-based
```python
offset = 0
page_size = 100
while True:
    data = self.fetch_page(offset=offset, size=page_size)
    if len(data) < page_size:
        break
    offset += page_size
```

## Header Templates

### Standard browser headers
```python
self.headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'fr-FR,fr;q=0.9,en;q=0.8',
    'Referer': self.base_url,
}
```

### GraphQL headers
```python
self.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/graphql-response+json; charset=utf-8',
    'Origin': self.base_url,
    # Copy x-dg-* headers from browser DevTools
}
```
