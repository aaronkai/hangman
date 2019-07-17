class SelectWord
  attr_accessor :filename, :min_length, :max_length
  
  def initialize
    @filename = "dictionary.txt"
    @min_length = 5
    @max_length = 12
  end
  
  def get_file_line_count
    line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
  end
  
  def random_word
    word = ""
    until word.length >= min_length && word.length <= max_length && word =~ /^[a-z]/
      word = IO.readlines("#{@filename}")[rand(get_file_line_count)].strip
    end
    word
  end
  
end