require 'rubygems'
require 'sinatra'
require 'twitter'
require 'haml'

get '/' do
  @results = Twitter::Search.new(' "fuck 2008" OR "fuck you 2008" OR "2008 sucks"')
  @results.per_page(100)
  haml :index, :options => {:format => :html4,
                            :attr_wrapper => '"'}
end

# stylesheet
get '/stylesheets/main.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  css :main
end
