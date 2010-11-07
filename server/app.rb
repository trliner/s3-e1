require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'
require 'cgi'
require 'json'
require 'lib/nibblet'
require 'erb'

get '/nibblet/json' do
  selectors = decode_selectors params[:selectors]
  url = decode_url params[:url]
  get_results(selectors, url).to_json
end

get '/nibblet/xls' do
  @selectors = decode_selectors params[:selectors]
  @results = get_results(@selectors, decode_url(params[:url]))
  headers "Content-Disposition" => "attachment; filename=nibblet",
          "Content-Type" => "application/vnd.ms-excel"
  erb :'xls.html'
end

def decode_selectors(selectors)
  JSON.parse(CGI::unescape(selectors))
end

def decode_url(url)
  CGI::unescape url
end

def get_results(selectors, url)
  selectors.each do |selector_key, opts|
    Nibblet.add_selector(selector_key, opts)
  end
  nibble = Nibblet.parse open(url)
  nibble.results_hash(selectors)
end