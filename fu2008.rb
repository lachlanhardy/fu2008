require 'rubygems'
require 'sinatra'
require 'twitter'
require 'haml'

use_in_file_templates!


get '/' do
  @results = Twitter::Search.new(' "fuck 2008" OR "fuck you 2008" OR "2008 sucks"')
  haml :index
end