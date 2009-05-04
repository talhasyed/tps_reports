require 'date'
require 'pp'

Dir["vc_adapters/*.rb"].each do |file|
  require file
end

require 'rubygems'

gem 'activesupport'
require 'activesupport'

# Adapter specific Stuff

# SVN
gem 'hpricot'
require 'hpricot'

# git
require 'grit'
include Grit
