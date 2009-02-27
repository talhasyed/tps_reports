require 'date'
require 'pp'

require 'rubygems'

gem 'hpricot'
require 'hpricot'

gem 'activesupport'
require 'activesupport'

Dir["vc_adapters/*.rb"].each do |file|
  require file
end
