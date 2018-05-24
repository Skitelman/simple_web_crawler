require "./config/environment"

EXIT_RESPONSES = ["9", "quit", "exit", "q",]
class Application
  def call
    welcome
    help
    response = ""
    urls = []
    until EXIT_RESPONSES.include?(response)
      puts "Please enter the number of a command: "
      response = gets.chomp.strip
      case response
      when "0", "help"
        help
      when "1"
        add_url_to_scan(urls)
      when "2"
        crawler = Crawler.new(urls)
        crawler.crawl
      end
    end
    puts "Goodbye"
  end

  private

  def help
    puts %(
      You can do one of the following:
        0: Help (displays this message)
        1: Add Url to visit
        2: Crawl Web
        9: Quit
      )
    end

    def welcome
      puts "Welcome to the Hustle Web Crawler\n"
    end

    def add_url_to_scan(urls)
      url = nil
      while url.nil?
        puts "Please enter the url you would like to scan: \n"
        url = gets.chomp.strip
        urls << url
      end
      puts "Will scan: #{url}"
    end
end
