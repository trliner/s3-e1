require 'rubygems'
require 'sinatra'
require 'nibbler'
require 'open-uri'

class Nibblet < Nibbler
end

get '/:domain/:selector' do
  Nibblet.element params[:selector] => :selected
  nibble = Nibblet.parse open("http://#{params[:domain]}")
  nibble.selected
end