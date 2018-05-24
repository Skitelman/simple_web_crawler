require "./config/environment"

class Crawler

  attr_reader :url_queue, :visited_urls, :phone_numbers
  def initialize(url_queue)
    @url_queue = url_queue
    @visited_urls = {}
    @phone_numbers = []
  end

  def crawl
    while !url_queue.empty?
      url = url_queue.shift
      next if visited_urls[url]

      puts "Scanning: #{url}"
      scanner = PageScanner.new(url)
      scanner.scan
      self.url_queue.concat(scanner.scanned_urls)
      puts scanner.phone_numbers
      self.write_phone_numbers(scanner.phone_numbers)
      visited_urls[url] = true
    end
    puts phone_numbers
  end

  def write_phone_numbers(phone_numbers)
    file = File.open('./phone_numbers.txt', 'w')
    file.write(phone_numbers)
    file.close
  end

end
