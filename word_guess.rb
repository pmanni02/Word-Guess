require 'faker'

#creates array with 10 random names. partitions first name of each character
simpsons = []
10.times do
  name = Faker::Simpsons.character.downcase
  name = name.partition(" ").first
  simpsons << name
end

class Game
  attr_accessor :lives, :word_bank, :initial_tries, :dashes, :flower_pot, :random_word

  def initialize(word_bank)
    @word_bank = word_bank
    @random_word = @word_bank.sample
    @lives = 5
    @dounut_pic = "
   _..------.._
  .'   .-\"\"-.   '.
  |\\   '----'   /|
  \\ `'--------'` /
  '._        _.'
     `\"\"\"\"\"\"`
     "
    @initial_tries = [@dounut_pic, @dounut_pic, @dounut_pic, @dounut_pic, @dounut_pic]
    @dashes = get_init_dashes
  end

  # Gives us array of dashes based on number of letters in random_word
  def get_init_dashes
    length = @random_word.length
    bucket_of_dash = []
    length.times do
      bucket_of_dash << " _ "
    end
    return bucket_of_dash
  end
end


class Words
  attr_accessor :split_letter_array, :correct_guesses, :words_lives, :selected_word, :tries_left

  def initialize(random_word, game_dashes, initial_tries, lives)
    @selected_word = random_word
    @correct_guesses = ""
    @split_letter_array = []
    @dashes = game_dashes
    @words_lives = lives
    @tries_left = initial_tries
  end

  #splits word into array of letter strings
  def split_word
    letters = @selected_word.split("")
    @split_letter_array = letters
  end

  #for correct_guesses letter is input into dash array
  def match_and_replace(guess)
      indices = []
      split_word.each_index do |i|
        if split_word[i] == guess
        indices << i
        end
      end

      indices.each do |index|
        @dashes[index] = guess
        @correct_guesses << guess
      end
  end


  def remove_life
    @words_lives -= 1
    @tries_left.pop()
  end

  #checks for alpha input
  def valid_letter(input_guess)
    if input_guess =~ /[a-zA-Z]/
      return true
    else
      return false
    end
  end

end

#displays donuts which represent tries. and displays letters guessed
def display(current_game, our_game)
   current_game.tries_left.each do |donut|
    print donut
  end

  our_game.dashes.each do |dash|
    print dash
  end
  puts
end

continue = " "
while continue != "n"
  #initializes each new game
  our_game = Game.new(simpsons)
  current_game = Words.new(our_game.random_word, our_game.dashes, our_game.initial_tries, our_game.lives)

  puts "
                                 ___    _
                                  | |_||_
      sssSSSSSs                   | | ||_
   sSSSSSSSSSSSs                           sSSSSs             nn   sSSSs
  SSSS           ii  mM     mmm   pPPPPpp sSS           nn    nn sSSSSSS
 SSSs           iII mMMMM  mMmmm pPP  PpppSs      oOoo  nNN   nN SS   SS
 SSSs           iII mMMMMM mM Mm Pp     PPSSSSs  OOOOOO NNNn nNN SSSs
 SSSSSSSssss    iIi mMM MMmM  Mm ppPPppPP  SSSSsoO   OO NNNNNNNN  SSSSss
    SSSSSSSSSs  iIi MMM  MMM  Mm PPPPppP      sSOO   OO NN  nNNN     SSSs
          SSSS IIi  mMM  MMm  Mm  Pp   sSSssSSSSOO ooOO nN   NN        SS
           sSS III   MM       MMm pPp    SSSSSS  OOOOO          sssssSsSS
sSSsssssSSSSS   II                                               SSSSSSS TM
  SSSSSSSSS

  "
puts "Homer gave you five donuts (tries). Every time you guess incorrectly, he eats one of your donuts!"

  #shows initial donuts and displays dash array
  our_game.initial_tries.each do |donut|
    print donut
  end
  puts "\n\n\n"
  our_game.dashes.each do |dash|
    print dash
  end

  #runs until user wins or loses
  until current_game.words_lives == 0 || current_game.correct_guesses.length == our_game.random_word.length
    print "\n\nGuess a letter: "
    guess = gets.chomp

    until current_game.valid_letter(guess)
      puts "Enter valid letter: "
      guess = gets.chomp
    end

    #if guess is correct, call match_and_replace
    if current_game.split_word.include? guess
      current_game.match_and_replace(guess)
    else
      #if guess is incorrect, call remove life
      current_game.remove_life
    end
    display(current_game, our_game)
  end

  #ask if they want to play again after game
  if current_game.words_lives == 0
    puts "You lost. DOH!"
    puts "The correct answer was #{current_game.selected_word.upcase}!"
    #deletes words already used in gameplay
    simpsons.delete(current_game.selected_word)
  else
    puts "You win"
    simpsons.delete(current_game.selected_word)
  end

  
  puts "Would you like to continue? (y/n)"
  continue = gets.chomp.downcase
  valid_continue_options = ["y", "n"]
  until valid_continue_options.include? continue
    print "Enter if you want to continue (y/n)"
    continue = gets.chomp.downcase
  end

end
