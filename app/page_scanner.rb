require "./config/environment"

class PageScanner

  attr_reader :url, :scanned_urls, :phone_numbers
  def initialize(url)
    @url = url
    @scanned_urls = []
    @phone_numbers = []
  end

  def scan
    doc = RestClient.get(self.url)

    ## Get Phone Numbers
    ## regex found here https://stackoverflow.com/a/16699507
    doc.body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4})/) do |number|
      self.phone_numbers << number.first
    end
    self.phone_numbers.uniq

    ## Get More Urls
    page = Nokogiri::HTML(RestClient.get(self.url))
    found_urls = page.css('a').map{ |link| clean_url(link['href']) if /^http/.match(link['href']) }.compact

    self.scanned_urls.concat(found_urls).uniq
  rescue => error
    puts "Error scanning #{self.url}"
  end

  def clean_url(url)
    parsed_url = URI.parse(url)
    parsed_url.query = nil
    parsed_url.to_s
  end
end
