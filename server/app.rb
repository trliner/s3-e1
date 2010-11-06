require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'
require 'cgi'

class Nibblet < Nibbler
end

get '/nibblet/:selector' do
  Nibblet.element params[:selector] => :selected
  url = CGI::unescape params[:url]
  nibble = Nibblet.parse open(url)
  nibble.selected
end