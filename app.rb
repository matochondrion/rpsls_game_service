require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/json"
require 'erubis'
require 'http'

RPSLS_WINNER_SERVER = 'http://54.70.36.146:4568'.freeze

configure do
  set :bind, '0.0.0.0'
  set :port, '4567'
end

helpers do
end

def computer_choice_id
  case retrieve_random_number
  when 1..20 then 1
  when 21..40 then 2
  when 41..60 then 3
  when 61..80 then 4
  when 81..100 then 5
  else
    raise 'random_number error'
  end
end

def retrieve_random_number
  # TODO: build in some error checking
  # https://github.com/httprb/http/wiki/Redirects
  #
  response = HTTP.accept(:json).follow(max_hops: 3)
                 .get('http://codechallenge.boohma.com/random')
  json = JSON.parse response.body
  json['random_number']
end

def get_winner(player_choice_id, computer_choice_id)
  #
  response = HTTP.accept(:json).follow(max_hops: 3)
                 .get(RPSLS_WINNER_SERVER)
  computer_choice_id
  'win'
end

get '/' do
  erb :index
end

get '/choices' do
  content_type :json
  retrieve_choices.to_json
end

get '/choice' do
  content_type :json
  {
    "id": 2,
    "name": 'paper'
  }.to_json
end

post '/play' do
  content_type :json

  game_data = {
    results: 'tbd',
    player: 2,
    computer: computer_choice_id
  }

  winner = get_winner game_data[:player], game_data[:computer]

  game_data['results'] = winner
  game_data.to_json
end
