class Game
  attr_accessor :word, :guesses
  
  def initialize(word)
    @word = word
    @rounds = 7
    @guesses = []
  end
 
  def get_guess
    puts "Pick a letter"
    letter = gets.chomp.downcase
  end
  
  def add_guess(guess)
    self.guesses.push(guess)
  end
  
  def display_word
    clue = []
    @word.split("").each do |letter|
      puts "guesses varible #{@guesses}"
      puts "letter #{letter}"
      
      if @guesses.include?(letter) 
        clue.push(letter) 
      else
        clue.push("__")
      end
    end
    clue.join(" ")
  end
  
  def play_game
    @rounds.times do |round|
      puts display_word
      puts "#{round} round(s) remaining"
      puts "Guess a letter:"
      self.guesses.push(gets.chomp.downcase)
    end
  end
end