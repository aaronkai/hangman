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

get '/guess' do 
  throw params.inspect 
  game.guesses.push(guess)
  game.evaluate_guesses(guess)
  erb :index, :locals => {:word => game.word,
                          :guesses => game.guesses,
                          :correct_guesses => game.correct_guesses,
                          :incorrect_guesses => game.incorrect_guesses
                          }
end

get '/test' do
  erb :test
end
