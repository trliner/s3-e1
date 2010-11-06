require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'
require 'cgi'
require 'json'

class Nibblet < Nibbler

  def self.add_selectors(selector_hash)
    selector_hash.default = {}
    selector_hash["single"].each do |element_key, selector|
      self.element selector => element_key.to_sym
    end
    selector_hash["multiple"].each do |element_key, selector|
      self.elements selector => element_key.to_sym
    end
  end

  def output_results(selector_hash)
    results = {}
    results[:single] = self.collect_elements(selector_hash["single"].keys)
    results[:multiple] = self.collect_elements(selector_hash["multiple"].keys)
    results.to_json
  end

  def collect_elements(element_keys)
    element_keys.collect{ |key| {key => self.send(key.to_sym)} }
  end
end

get '/nibblet' do
  selector_hash = decode_selectors params[:selectors]
  url = decode_url params[:url]
  Nibblet.add_selectors(selector_hash)
  nibble = Nibblet.parse open(url)
  nibble.output_results(selector_hash)
end

def decode_selectors(selectors)
  JSON.parse(CGI::unescape(selectors))
end

def decode_url(url)
  CGI::unescape url
end