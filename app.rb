require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/json"
require 'erubis'
require 'http'

# TODO: add api namespace

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
  response = HTTP.headers(accept: 'application/json').follow(max_hops: 3)
                 .get('http://codechallenge.boohma.com/random')
  json = JSON.parse response.body
  json['random_number']
end

def retrieve_winner(game_data)
  response = HTTP.headers(accept: 'application/json').follow(max_hops: 3)
                 .post(RPSLS_WINNER_SERVER, json: game_data)
  response.body.to_s
end

def valid_choice?(choice_id)
  choice_to_check = { choice_id: choice_id }

  response = HTTP.headers(accept: 'application/json').follow(max_hops: 3)
                 .post(RPSLS_WINNER_SERVER + '/is_valid_choice',
                       json: choice_to_check)

  JSON.parse(response.body)['is_valid']
end

def retrieve_choices
  response = HTTP.headers(accept: 'application/json').follow(max_hops: 3)
                 .get(RPSLS_WINNER_SERVER + '/choices')
  JSON.parse response.body
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
  request.body.rewind # in case someone already read it
  data = JSON.parse request.body.read

  player_choice = data['player'].to_i

  return 'Invalid Choice' unless valid_choice? player_choice

  game_data = {
    result: 'tbd',
    player: player_choice,
    computer: computer_choice_id
  }

  winner = retrieve_winner game_data
  game_data['result'] = winner
  game_data.to_json
end
