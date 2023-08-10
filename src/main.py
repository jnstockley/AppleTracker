from scrapping.software.ios import setup_browser, download_page, parse_page, get_wayback_url

if __name__ == '__main__':
    wayback_url = get_wayback_url(13)
    print(wayback_url)
    browser = setup_browser()
    html = download_page(browser, wayback_url)
    parse_page(html)
