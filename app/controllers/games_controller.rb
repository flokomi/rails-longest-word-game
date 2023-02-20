require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    abc = ('a'..'z').to_a
    @letters = []
    counter = 0

    while counter < 8
      @letters << abc.sample
      counter += 1
    end
  end

  def score
    @letters = params[:letters].split(' ')
    @guess = params[:guess]

    # Validating if letter exists
    @exists = @guess.split('').all? { |letter| @letters.include?(letter) }

    # Validating if letter is only uses once
    used_once = false
    @guess.chars.each do |letter|
      @used_once = @guess.count(letter) <= @letters.count(letter)
    end

    # Validating of it is an english word
    filepath = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    serialized_dictionary = URI.open(filepath).read
    parsed_dictionary = JSON.parse(serialized_dictionary)
    @english_word = parsed_dictionary['found']
  end
end
