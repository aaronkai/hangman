require './lib/select_word.rb'
require './lib/game.rb'
require 'yaml'


def load_game
 puts "Load a previously saved game (y/n)?"
 answer = gets.chomp.downcase until answer == "y" || answer == "n"
 if answer == "y"
   Dir.chdir('./save_states')
   files = Dir.glob('*') 
   puts "\nEnter the number of the saved game to load:"
   files.each_with_index do |file, index|
     puts "#{index}) #{file}"
   end
   file_number = gets.chomp.to_i
   save_game = YAML.load_file(files[file_number])
   save_game
 else 
   Game.new(SelectWord.new.random_word) 
 end
end
  
game = load_game  
# puts game.word
puts game.play_game