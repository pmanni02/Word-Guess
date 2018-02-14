simpsons = %w[Homer Marge Lisa Bart Nelson Ned Maggie]

class Game
  attr_accessor :lives, :word_bank, :initial_tries, :dashes, :flower_pot, :random_word

  def initialize(word_bank)
    @word_bank = word_bank
    @random_word = @word_bank.sample
    @lives = 5
    @initial_tries = %w[(@) (@) (@) (@) (@)]
    @dashes = get_init_dashes
    @flower_pot = "  ,\\,\\,|,/,/,
     _\\|/_
    |_____|
     |   |
     |___|"
    # @game_status = GameStatus.new
    # @display = Display.new
  end

  # Gives us array of dashes with number of letters
  def get_init_dashes
    length = @random_word.length
    bucket_of_dash = []
    length.times do
      bucket_of_dash << " __ "
    end
    return bucket_of_dash
  end
end


class Words

  attr_accessor :split_letter_array, :correct_guesses, :lives, :selected_word, :initial_tries

  def initialize(random_word, game_dashes)
    @selected_word = random_word
    @correct_guesses = ""
    @split_letter_array = []
    @lives = 5
    @initial_tries = %w[(@) (@) (@) (@) (@)]
    @dashes = game_dashes
    # @dash_array = dash
  end

  def split_word
    letters = @selected_word.split("")
    @split_letter_array = letters
  end

  def match_and_replace(guess)
      #indices = split_word.each_index.select{|i| split_word[i] == guess}
      indices = []
      split_word.each_index do |i|
        if split_word[i] == guess
        indices << i
        end
      end

      puts "Indices is #{indices}"
      indices.each do |index|
        puts "dashes is #{@dashes}"
        @dashes[index] = guess
        puts "new dashes is #{@dashes}"
        @correct_guesses << guess
      end
  end

  def remove_life
    @lives -= 1
    @initial_tries.pop()
  end


  def valid_letter(input_guess)
    if input_guess =~ /[a-zA-Z]/ # Come back to duplicates || input_guess != (@correct_guesses.include? input_guess)
      return true
    else
      return false
    end
  end

end

our_game = Game.new(simpsons)
current_game = Words.new(our_game.random_word, our_game.dashes)

our_game.initial_tries.each do |flower|
  print flower
end

puts "\n#{our_game.flower_pot}"
our_game.dashes.each do |dash|
  print dash
end

puts our_game.random_word

puts "Guess a letter: "
guess = gets.chomp

until current_game.valid_letter(guess)
  puts "Enter valid letter: "
  guess = gets.chomp
end

if current_game.split_word.include? guess
  current_game.match_and_replace(guess)
else
  current_game.remove_life
end

# continue = " "
# while continue != n
  our_game.initial_tries.each do |flower|
    print flower
  end

  puts "\n#{our_game.flower_pot}"
  our_game.dashes.each do |dash|
    print dash
  end

  puts our_game.random_word

  puts "Guess a letter: "
  guess = gets.chomp

  until current_game.valid_letter(guess)
    puts "Enter valid letter: "
    guess = gets.chomp
  end

  if current_game.split_word.include? guess
    current_game.match_and_replace(guess)
  else
    current_game.remove_life
  end

# end

puts "#{our_game.random_word}"
puts "#{current_game.selected_word}"
puts "#{current_game.split_word}"
puts our_game.lives.class
puts current_game.lives
puts current_game.initial_tries
