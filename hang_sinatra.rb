require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/select_word.rb'
require_relative 'lib/game.rb'
require 'yaml'


game = Game.new(SelectWord.new.random_word) 


get '/' do 
  erb :index, :locals => {:word => game.word,
                          :key => game.display_key('stdout')
                          }
end

post '/guess' do 
  last_guess = params['guess']
  game.guesses.push(last_guess)
  game.evaluate_guesses
  game.current_round += 1
  #need to add logic for determining loss, saving game, and loading game.
  erb :in_game, :locals => {:word => game.word,
                          :key => game.display_key('stdout'),
                          :winner => game.winner?,
                          :rounds_remaining =>game.rounds - game.current_round,
                          :guesses => game.guesses
                          }
end

get '/forfeit' do
  game = Game.new(SelectWord.new.random_word) 
  erb :index, :locals => {:word => game.word,
                          :key => game.display_key('stdout')
                          }
end

get '/load' do
  erb :load
end

get '/load/:file' do 
  Dir.chdir('./save_states')
  game = YAML.load_file( params['file'] )
  Dir.chdir('..')
  erb :in_game, :locals => {:word => game.word,
                        :key => game.display_key('stdout'),
                        :winner => game.winner?,
                        :rounds_remaining =>game.rounds - game.current_round,
                        :guesses => game.guesses
                        }
end

get '/save' do 
  game.save_game
  redirect to('forfeit')
end

