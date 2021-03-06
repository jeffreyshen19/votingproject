require 'sinatra'
require 'yaml/store'


get '/' do
  @title = 'SINCE THE ELECTION BECAME A GAME VOTE AS MUCH AS YOU WANT'
  erb :index
end

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

Choices = {
  'BERN' => 'Bernie Sanders',
  'BID' => 'Joe Biden',
  'BOR' => 'Boris Shmuylovich',
  'DJT' => 'Donald Trump',
  'VLD' => 'Vladimir Putin',
}
