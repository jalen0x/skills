---
name: product-scraper
description: "Build Python scrapers to extract product URLs from e-commerce websites. Use this skill when: (1) User wants to scrape products from an online store, (2) User needs to extract product listings from category pages, (3) User asks to build a web scraper for e-commerce sites, (4) User mentions keywords like 爬虫, 抓取商品, scrape products, fetch URLs."
---

# Product Scraper

Build Python scrapers to extract product URLs from e-commerce websites using their APIs.

## Workflow

### Step 1: Analyze the Target Website

Open the target category page in browser DevTools (Network tab):
1. Click "Load More" or pagination buttons
2. Identify the API request that returns product data
3. Note the request type (GraphQL POST / REST GET)
4. Check response format (JSON or HTML)

**Key things to find:**
- API endpoint URL
- Pagination parameters (`page`, `offset`, `after`, `cursor`)
- Category ID (often in URL path: `/category-name-123` → `123`)
- Required headers (especially `x-*` custom headers)

### Step 2: Test the API

Test in browser console with `fetch()`:
```javascript
fetch('/api/products?page=1&category=123')
  .then(r => r.json())
  .then(console.log)
```

Confirm:
- Pagination pattern (page number, offset, or cursor)
- Termination condition (empty response, `hasNextPage: false`)
- Product URL location in response

### Step 3: Build the Scraper

Use the class template from `references/scraper-template.md`.

**API type determines parsing:**
- **JSON response** → Direct field extraction
- **HTML response** → Parse with `lxml` + XPath

See `references/api-patterns.md` for specific patterns per API type.

### Step 4: Configure Categories

Add target categories to scraper config:
```python
self.categories = [
    {"name": "Jewelry", "id": 2840},
    {"name": "Watches", "id": 2850},
]
```

Category IDs are typically found in:
- URL path: `/bijoux-2840` → `2840`
- Page source: `window.rayonId = 2840`
- Network request params

## Key Implementation Rules

1. **Incremental file writing** - Append URLs as fetched, not batch at end
2. **Set deduplication** - Use `Set[str]` for `all_urls`
3. **Consecutive empty check** - Stop after 2 empty pages
4. **30-second timeout** - All requests
5. **Polite delay** - `time.sleep(1)` between requests
6. **Absolute URLs** - Always `base_url + relative_path`
7. **Chinese output** - Use emojis + Chinese for console messages

## Dependencies

```
requests
lxml
```

## References

- **API patterns**: See `references/api-patterns.md` for GraphQL, REST HTML, REST JSON examples
- **Class template**: See `references/scraper-template.md` for full boilerplate code
