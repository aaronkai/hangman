require './lib/select_word.rb'
require './lib/game.rb'
require 'yaml'

# game_word = SelectWord.new
# puts game_word.random_word
game = Game.new(SelectWord.new.random_word)
puts game.word
puts game.play_game