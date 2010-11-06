require '../client/nibblet_client.rb'

selectors = {}
selectors[:single] = {:results => "div#ires"}
google = NibbletClient.new("http://www.google.com/search?q=ruby+resources", selectors)
puts google.scrape