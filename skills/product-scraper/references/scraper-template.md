# Scraper Class Template

## Basic Structure

```python
import requests
from lxml import etree  # For HTML parsing
from datetime import datetime
from typing import List, Set

class SiteScraper:
    """Site Name 商品爬虫"""

    def __init__(self):
        self.base_url = "https://www.example.com"
        self.api_url = f"{self.base_url}/api/products"
        self.all_urls: Set[str] = set()
        self.output_file = None

        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'fr-FR,fr;q=0.9,en;q=0.8',
            'Referer': self.base_url,
        }

        # Category configs
        self.categories = [
            {"name": "Category1", "id": 123},
            {"name": "Category2", "id": 456},
        ]

    def fetch_page(self, category_id: int, page: int) -> str:
        """Fetch single page content"""
        params = {'page': page, 'category': category_id}
        try:
            response = requests.get(
                self.api_url,
                params=params,
                headers=self.headers,
                timeout=30
            )
            response.raise_for_status()
            return response.text
        except requests.exceptions.RequestException as e:
            print(f"    ❌ 请求失败: {e}")
            return ""

    def parse_product_urls(self, content: str) -> List[str]:
        """Extract product URLs from response"""
        if not content:
            return []
        urls = []
        try:
            tree = etree.HTML(content)
            links = tree.xpath('//a[@href][contains(@class, "product")]')
            for link in links:
                href = link.get('href')
                if href and href.startswith('/'):
                    urls.append(self.base_url + href)
        except Exception as e:
            print(f"    ⚠️ 解析失败: {e}")
        return urls

    def _append_urls_to_file(self, urls: List[str]):
        """Append URLs to file incrementally"""
        if not urls or not self.output_file:
            return
        with open(self.output_file, 'a', encoding='utf-8') as f:
            for url in urls:
                f.write(url + '\n')

    def fetch_category(self, name: str, category_id: int):
        """Fetch all products from a category"""
        print(f"\n{'='*60}")
        print(f"开始抓取: {name} (id={category_id})")
        print(f"{'='*60}\n")

        category_urls = []
        page = 1
        consecutive_empty = 0

        while consecutive_empty < 2:
            print(f"  📄 正在获取第 {page} 页...", end=" ")
            content = self.fetch_page(category_id, page)
            urls = self.parse_product_urls(content)

            if not urls:
                consecutive_empty += 1
                print(f"❌ 无数据 (连续空页: {consecutive_empty})")
            else:
                consecutive_empty = 0
                for url in urls:
                    if url not in self.all_urls:
                        category_urls.append(url)
                        self.all_urls.add(url)
                self._append_urls_to_file(urls)
                print(f"✅ {len(urls)} 个商品 (累计: {len(category_urls)})")

            page += 1
            time.sleep(1)  # Polite delay

        print(f"\n分类 [{name}] 完成: {len(category_urls)} 个产品\n")
        return category_urls

    def fetch_all(self):
        """Fetch all configured categories"""
        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        self.output_file = f"{timestamp}_product_urls.txt"

        with open(self.output_file, 'w') as f:
            pass  # Create empty file

        print(f"\n🚀 开始批量抓取...")
        print(f"⏰ 开始时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"📋 分类数量: {len(self.categories)}")
        print(f"💾 输出文件: {self.output_file}\n")

        for idx, cat in enumerate(self.categories, 1):
            print(f"\n[{idx}/{len(self.categories)}]")
            self.fetch_category(cat["name"], cat["id"])

        print(f"\n{'='*60}")
        print(f"✨ 抓取完成!")
        print(f"🔗 总 URL 数 (去重后): {len(self.all_urls)}")
        print(f"💾 输出文件: {self.output_file}")
        print(f"{'='*60}\n")


if __name__ == "__main__":
    scraper = SiteScraper()
    scraper.fetch_all()
```

## Key Methods

| Method | Purpose |
|--------|---------|
| `__init__` | Configure URLs, headers, categories |
| `fetch_page` | Send HTTP request, return raw response |
| `parse_product_urls` | Extract URLs from response (HTML/JSON) |
| `_append_urls_to_file` | Incremental file writing |
| `fetch_category` | Paginate through single category |
| `fetch_all` | Orchestrate all categories |

## Conventions

- **Chinese output**: Use emojis + Chinese for console messages
- **Set deduplication**: `self.all_urls: Set[str]`
- **30s timeout**: All requests use `timeout=30`
- **Incremental save**: Write URLs as fetched, not at end
- **Absolute URLs**: Always `base_url + relative_path`
- **Consecutive empty check**: Stop after 2 empty pages
