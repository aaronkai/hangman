class Game
  attr_accessor :word, :guesses, :correct_guesses, :incorrect_guesses
  
  def initialize(word)
    @word = word
    @rounds = @word.length * 2
    @guesses = []
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def round_text(round)
    puts "Wrong guesses: #{incorrect_guesses.join(" ")}"
    puts "#{round} round(s) remaining"
    puts "Guess a letter:"
  end
  
  def display_key(output)
    clue = []
    @word.split("").each do |letter|
      @guesses.include?(letter) ?  clue.push(letter) : clue.push("__")
    end
    clue.join(" ")   
    output == "stdout" ? clue.join(" ") : clue.join("")
  end  
  
  def get_guess
    puts "Pick a letter"
    letter = gets.chomp.downcase
    guesses.push(letter)
    letter
  end
   
  def evaluate_guesses
    last_guess = guesses[-1]
    if word.split("").include?(last_guess)
      correct_guesses.push(last_guess) unless correct_guesses.include?(last_guess)
    else
      incorrect_guesses.push(last_guess)
    end
  end
  
  def winner?
    correct_guesses.sort == word.split("").sort.uniq ? true : false
  end
  
  def lost_round
    puts display_key("stdout")
    answer = ""
    puts "Do you want to save your game and quit(y/n)?" 
    answer = gets.chomp.downcase until answer == "y" || answer == "n"
    save_game if answer == "y"   
  end
    
  def save_game
    file_name = "save_states/#{display_key("save")}.savestate.yaml"
    save_handle = File.open(file_name, "w"){ |file| file.puts(YAML::dump(self)) }
    exit
  end
  
  def play_game
    @rounds.times do |round|
      round_text(@rounds - round)
      puts display_key("stdout")
      get_guess
      evaluate_guesses
      if winner?
        puts "YOU WIN"
        break
      else
        lost_round
      end
      puts "###\n\n"
    end
  end
end