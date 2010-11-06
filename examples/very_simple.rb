require '../client/nibblet_client.rb'

rmu = NibbletClient.new("http://university.rubymendicant.com", "#menu_bar")

puts rmu.scrape