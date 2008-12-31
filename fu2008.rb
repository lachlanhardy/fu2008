require 'rubygems'
require 'sinatra'
require 'twitter'
require 'haml'

BLACKLISTED_STRINGS = ["Office 2008", "server 2008", "xxx", "MacOffice", "Online information 2008", "sure like to fuck you 2008"]

# reset stylesheet
get '/stylesheets/reset.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  css :reset
end

# main stylesheet
get '/stylesheets/main.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  css :main
end

# homepage
get '/' do
  @results = []
  @search = Twitter::Search.new(' "fuck 2008" OR "fuck you 2008" OR "2008 sucks" OR #2008sux0r')
  @search.per_page(100)
  @search.each do |item|
    unless BLACKLISTED_STRINGS.any? {|i| item["text"].match(i)}
      @results << item["text"].gsub(/^@\w[a-z]+\s/, '').
        gsub(/((ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?)/i, '<a href="\1">\1</a>').
        gsub(/(fuck you 2008\W?|fuck 2008\W?|2008 sucks\W?|#2008sux0r)/i, '<strong>\1</strong>').
        gsub(/(fuck yeah 2009\W?)/i, '<em>\1</em>')
    end
  end
  
  
  haml :index, :options => {:format => :html4,
                            :attr_wrapper => '"'}
end

# colophon
get '/colophon' do
  haml :colophon, :options => {:format => :html4,
                            :attr_wrapper => '"'}
end
