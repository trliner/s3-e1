require '../client/nibblet_client.rb'

selectors = {
  :title => {
    :selector => "h1"
  },
  :subtitle => {
    :selector => "h2"
  },
  :buttons => {
    :selector => "div.box h3",
    :multiple => true
  },
  :info => {
    :selector => "div#overview .info",
    :multiple => true
  }
}
rmu = NibbletClient.new("http://university.rubymendicant.com", selectors)
puts rmu.scrape