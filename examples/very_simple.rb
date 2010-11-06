require 'client/nibblet_client.rb'

rmu = NibbletClient.new("http://university.rubymendicant.com", "h1")

puts rmu.scrape