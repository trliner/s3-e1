require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'
require 'cgi'

class Nibblet < Nibbler
end

get '/nibblet' do
  selector = CGI::unescape params[:selector]
  url = CGI::unescape params[:url]
  Nibblet.element selector => :selected
  nibble = Nibblet.parse open(url)
  nibble.selected
end