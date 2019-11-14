require 'sinatra'
require 'sinatra/reloader'
require './lib/select_word.rb'
require './lib/game.rb'

game = Game.new(SelectWord.new.random_word) 


get '/' do 
  erb :index, :locals => {:word => game.word,
                          :guesses => game.guesses,
                          :correct_guesses => game.correct_guesses,
                          :incorrect_guesses => game.incorrect_guesses,
                          :key => game.display_key('stdout')
                          }
end

post '/guess' do 
#   throw params.inspect 
  last_guess = params['guess']
  game.guesses.push(last_guess)
  game.evaluate_guesses
  erb :index, :locals => {:word => game.word,
                          :guesses => game.guesses,
                          :correct_guesses => game.correct_guesses,
                          :incorrect_guesses => game.incorrect_guesses,
                          :key => game.display_key('stdout')

                          }
end

get '/test' do
  erb :test
end
