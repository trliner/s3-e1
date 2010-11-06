require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'
require 'cgi'
require 'json'

class Nibblet < Nibbler

  def self.add_selectors(selectors)
    selectors.each do |key, selector|
      self.element selector => key.to_sym
    end
  end

  def output_results(keys)
    keys.collect{ |key| {key => self.send(key.to_sym)} }.to_json
  end
end

get '/nibblet' do
  selectors = decode_selectors params[:selectors]
  url = decode_url params[:url]
  Nibblet.add_selectors(selectors)
  nibble = Nibblet.parse open(url)
  nibble.output_results(selectors.keys)
end

def decode_selectors(selectors)
  JSON.parse(CGI::unescape(selectors))
end

def decode_url(url)
  CGI::unescape url
end