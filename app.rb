require 'bundler'
Bundler.require
require 'sinatra/reloader'

client = Tumblr::Client.new({
  :consumer_key => ENV['CONSUMER_KEY'],
  :consumer_secret => ENV['CONSUMER_SECRET'],
  :oauth_token => ENV['OAUTH_TOKEN'],
  :oauth_token_secret => ENV['OAUTH_TOKEN_SECRET']
})


get '/search/photo' do
  results = client.tagged(params['q'])

  urls = []

  results.each do |result|
    next unless result['type'] == 'photo'

    photos = result['photos']

    photos.each do |photo|
      urls <<  photo['original_size']['url']
    end
  end

  json urls
end
