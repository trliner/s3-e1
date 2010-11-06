require 'rubygems'
require 'httparty'
require 'cgi'
require 'json'

class NibbletClient
  include HTTParty
  base_uri "http://localhost:4567/"

  def initialize(url, selectors)
    @encoded_url = encode_url(url)
    @encoded_selectors = encode_selectors(selectors)
  end

  def scrape
    params = { :url => @encoded_url, :selectors => @encoded_selectors }
    self.class.get("/nibblet", :query => params).parsed_response
  end

  private

  def encode_url(url)
    CGI::escape url
  end

  def encode_selectors(selectors)
    CGI::escape selectors.to_json
  end

end