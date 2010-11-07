require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'
require 'cgi'
require 'json'
require 'lib/nibblet'

get '/nibblet' do
  selectors = decode_selectors params[:selectors]
  url = decode_url params[:url]
  selectors.each do |selector_key, opts|
    Nibblet.add_selector(selector_key, opts)
  end
  nibble = Nibblet.parse open(url)
  nibble.results_hash(selectors).to_json
end

def decode_selectors(selectors)
  JSON.parse(CGI::unescape(selectors))
end

def decode_url(url)
  CGI::unescape url
end