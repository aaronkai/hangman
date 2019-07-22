class Game
  attr_accessor :word, :guesses, :correct_guesses, :incorrect_guesses
  
  def initialize(word)
    @word = word
    @rounds = @word.length * 2
    @guesses = []
    @correct_guesses = []
    @incorrect_guesses = []
    @current_round = 1
  end
  
  def round_text(round)
    puts "Wrong guesses: #{incorrect_guesses.join(" ")}"
    puts "#{@rounds - @current_round +1} round(s) remaining"
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
    if @current_round > @rounds
      puts "YOU LOSE"
      puts "Secret word was #{word}"
      exit
    end
    puts display_key("stdout")
    answer = ""
    puts "Do you want to save your game and quit(y/n)?" 
    answer = gets.chomp.downcase until answer == "y" || answer == "n"
    save_game if answer == "y"   
  end
    
  def save_game
    Dir.chdir("save_states")
    file_name = "#{display_key("save")}.savestate.yaml"
    save_handle = File.open(file_name, "w"){ |file| file.puts(YAML::dump(self)) }
    exit
  end
  
  def play_game
    until @current_round > @rounds do
      round_text(@current_round)
      puts display_key("stdout")
      get_guess
      evaluate_guesses
      @current_round += 1
      if winner?
        puts display_key("stdout")
        puts "YOU WIN in #{@current_round} rounds"
        break
      else
        lost_round
      end
      puts "###\n\n"
    end
  end
end