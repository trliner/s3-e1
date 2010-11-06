require 'rubygems'
require 'httparty'
require 'cgi'

class NibbletClient
  include HTTParty
  base_uri "http://localhost:4567/"

  def initialize(url, selector)
    @escaped_url = CGI::escape url
    @selector = selector
  end

  def scrape
    params = { :url => @escaped_url }
    self.class.get("/nibblet/#{@selector}", :query => params).parsed_response
  end

end