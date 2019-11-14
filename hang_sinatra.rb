require 'sinatra'
require 'sinatra/reloader'
require './lib/select_word.rb'
require './lib/game.rb'

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
  erb :index, :locals => {:word => game.word,
                          :key => game.display_key('stdout'),
                          :winner => game.winner?,
                          :rounds_remaining =>game.rounds - game.current_round
                          }
end

get '/test' do
  erb :test
end
