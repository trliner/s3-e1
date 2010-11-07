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
    selector_hash["block"].each do |block_key, opts|
      self.elements opts["selector"] => block_key.to_sym do
        opts["block"].each do |element_key, selector|
          self.element selector => element_key.to_sym
        end
      end
    end
  end

  def output_results(selector_hash)
    results = {}
    results[:single] = self.collect_elements(selector_hash["single"].keys)
    results[:multiple] = self.collect_elements(selector_hash["multiple"].keys)
    results[:block] = self.collect_iterators(selector_hash["block"])
    results.to_json
  end

  def collect_elements(element_keys)
    element_keys.collect{ |key| {key => self.send(key.to_sym)} }
  end

  def collect_iterators(selector_type)
    selector_type.keys.collect do |b_key|
      block_keys = selector_type[b_key.to_s]["block"].keys
      block_array = self.send(b_key.to_sym).inject([]) do |array, iterator|
        element_hash = block_keys.inject({}) do |hash, e_key|
          element = iterator.send(e_key.to_sym)
          hash.merge(e_key => element)
        end
        array << element_hash
      end
      {b_key => block_array}
    end
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