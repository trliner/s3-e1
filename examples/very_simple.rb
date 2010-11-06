require '../client/nibblet_client.rb'

rmu = NibbletClient.new("http://university.rubymendicant.com", :title => "h1", :subtitle => "h2")

puts rmu.scrape