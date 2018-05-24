require "./config/environment"

urls = ["https://www.yelp.com/biz/muraccis-japanese-curry-and-grill-san-francisco", "butts"]

crawler = Crawler.new(urls)

crawler.crawl
