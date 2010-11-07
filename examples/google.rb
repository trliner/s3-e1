require '../client/nibblet_client.rb'

selectors = {}
selectors[:block] = {
  :results => {
    :selector => "div#ires li",
    :block => {:title => "h3.r a", :url => "h3.r a/@href"}
  }
}
google = NibbletClient.new("http://www.google.com/search?q=ruby+resources", selectors)
puts google.scrape