require 'rubygems'
require 'httparty'

class NibbletClient
  include HTTParty
  base_uri "http://localhost:4567/"

  def initialize(domain, selector)
    @domain = domain
    @selector = selector
  end

  def scrape
    self.class.get("/#{@domain}/#{@selector}").parsed_response
  end

end