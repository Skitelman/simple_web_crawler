require "bundler/setup"
Bundler.require(:default, :development)
$: << "."

Dir["app/*.rb"].each {|f| require f}
