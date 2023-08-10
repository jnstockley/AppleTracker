import requests
import json
from playwright.sync_api import sync_playwright, Browser
from selectolax.parser import HTMLParser

WAYBACK_URL = "http://archive.org/wayback/available"

BASE_URL: str = "https://www.apple.com/ios/ios-"

IOS_VERSION: list[int] = [16, 15, 14, 13]


def get_wayback_url(ios_version: int) -> str | None:
    params = {"url": f'{BASE_URL}{ios_version}/'}
    response = requests.get(WAYBACK_URL, params=params)
    if response.ok:
        json_data = json.loads(response.text)
        archived_snapshots = json_data['archived_snapshots']
        closest = archived_snapshots['closest']
        status: int = int(closest['status'])
        available: bool = bool(closest['available'])
        url: str = closest['url']
        if status == 200 and available is True:
            return url
    return None


def setup_browser() -> Browser:
    pw = sync_playwright().start()
    browser = pw.chromium.launch(headless=True)
    return browser


def download_page(browser: Browser, wayback_url: str) -> HTMLParser:
    page = browser.new_page()
    page.goto(wayback_url)
    html = HTMLParser(page.content())
    return html


def parse_page(html: HTMLParser):
    tagline: str = ""
    devices: list[str] = [""]

    tagline_span = html.css_first("span.typography-hero-headline")
    tagline_p = html.css_first("p.typography-hero-headline")
    tagline_h2 = html.css_first("h2.hero-headline")

    devices_list = html.css_first("ul.list")
    devices_div = html.css_first("div.devices")

    if tagline_span is not None:
        tagline = tagline_span.text()
    elif tagline_p is not None:
        tagline = tagline_p.text()
    elif tagline_h2 is not None:
        tagline = tagline_h2.text()

    if devices_list is not None:
        devices = devices_list.text().strip().replace("\t", "").replace(u'\xa0', ' ').split("\n")
    elif devices_div is not None:
        devices = devices_div.text().strip().replace("\t", "").replace(u'\xa0', ' ').split("\n")

    print(tagline)
    print(devices)
    return


'''
INFO TO GATHER
1. logo
2. Introduced date (ipsw.me???)
3. About
4. Supported devices (main page)
5. Distribution (probably stays same)
6. Version  (ipsw.me???)
7. Tagline (main page)
'''
