require '../client/nibblet_client.rb'

selectors = {}
selectors[:single] = {:title => "h1", :subtitle => "h2"}
selectors[:multiple] = {:buttons => "div.box h3", :info => "div#overview .info"}
rmu = NibbletClient.new("http://university.rubymendicant.com", selectors)
puts rmu.scrape