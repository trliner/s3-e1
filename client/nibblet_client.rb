require 'rubygems'
require 'httparty'
require 'cgi'

class NibbletClient
  include HTTParty
  base_uri "http://localhost:4567/"

  def initialize(url, selector)
    @escaped_url = CGI::escape url
    @escaped_selector = CGI::escape selector
  end

  def scrape
    params = { :url => @escaped_url, :selector => @escaped_selector }
    self.class.get("/nibblet", :query => params).parsed_response
  end

end