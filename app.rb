require 'sinatra'
require 'sinatra/namespace'
require "sinatra/reloader" if development?
require "sinatra/json"
require 'erubis'
require 'http'

RPSLS_WINNER_SERVER = 'http://54.70.36.146:4568/api'.freeze

# TODO: add config for
#       - URLs
#       - ports

configure do
  set :bind, '0.0.0.0'
  set :port, '4567'
  set :public_folder, Proc.new { File.join(root, "lib/app/public") }
  set :views, Proc.new { File.join(root, "lib/app/views") }
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

def retrieve_winner(players_data)
  response = HTTP.headers(accept: 'application/json').follow(max_hops: 3)
                 .post(RPSLS_WINNER_SERVER + '/compute_winner',
                       json: players_data)

  response.body
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

def random_choice
  choices = retrieve_choices
  choices[rand choices.length]['choice']
end

get '/' do
  # erb :index
  File.read(File.join('lib/app/views', 'index.html'))
end

namespace '/api' do
  get '/choices' do
    content_type :json
    retrieve_choices.to_json
  end

  get '/choice' do
    content_type :json

    random_choice.to_json
  end

  post '/play' do
    content_type :json
    request.body.rewind # in case someone already read it
    data = JSON.parse request.body.read

    player_choice_id = data['player'].to_i

    return 'Invalid Choice' unless valid_choice? player_choice_id

    players_data = [{ name: 'player', choice_id: player_choice_id },
                    { name: 'computer', choice_id: computer_choice_id }]

    players_data = retrieve_winner players_data

    players_data.to_json
  end
end
