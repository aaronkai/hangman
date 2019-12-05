require 'sinatra'
if development? 
  require 'sinatra/reloader'
end
require_relative 'lib/select_word.rb'
require_relative 'lib/game.rb'
require 'yaml'


game = Game.new(SelectWord.new.random_word) 


get '/' do 
  erb :index, :locals => {:word => game.word,
                          :key => game.display_key('stdout'),
                          :winner => game.winner?,
                          :rounds_remaining =>game.rounds - game.current_round,
                          :bad_guesses => game.incorrect_guesses,
                          }
end

post '/guess' do 
  last_guess = params['guess']
  game.guesses.push(last_guess)
  game.evaluate_guesses
  game.current_round += 1
  #need to add logic for determining loss, saving game, and loading game.
  erb :index, :locals => {:word => game.word,
                          :key => game.display_key('stdout'),
                          :winner => game.winner?,
                          :rounds_remaining =>game.rounds - game.current_round,
                          :bad_guesses => game.incorrect_guesses,
                          }
end

get '/forfeit' do
  game = Game.new(SelectWord.new.random_word) 
  redirect to('/')
end

get '/load' do
  erb :load
end

get '/load/:file' do 
  if params['file']
    redirect to ('forfeit')
  end
  Dir.chdir('./save_states')
  game = YAML.load_file( params['file'] )
  Dir.chdir('..')
  erb :index, :locals => {:word => game.word,
                        :key => game.display_key('stdout'),
                        :winner => game.winner?,
                        :rounds_remaining =>game.rounds - game.current_round,
                        :guesses => game.guesses,
                        :bad_guesses => game.incorrect_guesses
                        }
end

get '/save' do 
  game.save_game
  redirect to('forfeit')
end

