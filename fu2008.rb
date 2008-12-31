require 'rubygems'
require 'sinatra'
require 'twitter'
require 'haml'

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
  if $last_updated + 300 < Time.now # hasn't been updated for 5 mins. - 300 secs
    @results = []
  
    @search = Twitter::Search.new(' "fuck 2008" OR "fuck you 2008" OR "2008 sucks" OR #2008sux0r')
    @search.per_page(100)
    @search.each do |item|
      unless BLACKLISTED_STRINGS.any? {|i| item["text"].downcase.match(i.downcase)}
          @results << item["text"].gsub(/^@\w[a-z]+\s/, '').
            gsub(/((ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?)/i, '<a href="\1">\1</a>').
            gsub(/(fuck you 2008\W?|fuck 2008\W?|2008 sucks\W?|#2008sux0r)/i, '<strong>\1</strong>').
            gsub(/(fuck yeah 2009\W?)/i, '<em>\1</em>')
      end
    end
    
    Cache["index"] = haml :index, :options => {:format => :html4,
                              :attr_wrapper => '"'}
    $last_updated = Time.now
  end
  Cache["index"]
end

# colophon
get '/colophon' do
  haml :colophon, :options => {:format => :html4,
                            :attr_wrapper => '"'}
end

# Configure Block.
configure do
  Cache = {}      # Create a new cache
  $last_updated = Time.now - 100000 # ensure the first request is outdated.
  BLACKLISTED_STRINGS = []
  # read blacklist file.
  File.open(File.join(File.dirname(__FILE__), '/blacklist.txt'), 'r') do |file|
    while line = file.gets  
        BLACKLISTED_STRINGS << line.strip 
    end  
  end
end
