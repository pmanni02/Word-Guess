#categories
simpsons = %w[Homer Marge Lisa Bart Nelson Ned Maggie]

class Words

  def initialize(category)
    @category = category
    @lives = 5
    @word = @category.sample

  end

  def dash
    puts "#{@word}"
    dashes = []
    puts "#{@word.length}"
    length = @word.length
    puts "The word length is: #{length}"
    length.times do
      dashes << " __ "
    end
      # print " __ "
    return dashes
  end

  def split_word
    letters = @word.split("")
    print letters
    return letters
  end

  # def guess

  #   puts "Enter letter: "
  #   until valid_letter(guess)
  #     puts "Enter valid letter: "
  #     guess = gets.chomp
  #   end
  #   return guess
  # end

  def match_and_replace(guess)
    letter_array = split_word
    if letter_array.include? guess
      puts "#{p letter_array.each_index.select{|i| letter_array[i] == guess}}"
      indices = p letter_array.each_index.select{|i| letter_array[i] == guess}
      dash_array = dash
      indices.each do |index|
        dash_array[index] = guess
      end
      print dash_array
    end
  end

end



def valid_letter(input_guess)
  if input_guess =~ /[a-zA-Z]/
    return true
  else
    return false
  end
end

test = Words.new(simpsons)
# test.random_word
puts "#{test.dash}"
test.split_word
puts "Enter letter: "
guess = gets.chomp
until valid_letter(guess)
  puts "Enter valid letter: "
  guess = gets.chomp
end
test.match_and_replace(guess)
# i = 1
#
# while lives =! 0
# puts "Guess: "
# guess
# counter += 1
# puts "Guess number #{counter} is #{guess}"
# end
