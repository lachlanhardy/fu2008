require 'rubygems'
require 'sinatra'
require 'twitter'
require 'haml'

get '/' do

  haml :index
  
end