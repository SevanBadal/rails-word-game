require 'open-uri'
class GamesController < ApplicationController
  
  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    grid = []
    grid_size.times { grid << rand(65..90).chr }
    grid
  end

  def english_word?(attempt)
    base_url = "https://wagon-dictionary.herokuapp.com/"
    web_url = base_url + attempt
    string = open(web_url).read
    hash = JSON.parse(string)
    hash["found"]
  end
  
  def in_grid?(attempt, grid)
    return false if attempt.length > grid.length

    chars = {}
    grid.each { |c| chars[c].nil? ? chars[c] = 1 : chars[c] += 1 }
    attempt.chars.each { |let| chars[let].nil? ? chars[let] = -1 : chars[let] -= 1 }
    chars.value?(-1) ? false : true
  end
  def new
    @grid = generate_grid(12)
  end

  def score
    @word = params[:word].upcase
    puts @words.class
    @grid = params[:grid].split(' ')
    @a_word = english_word?(@word)
    @in_grid = in_grid?(@word, @grid)
    @valid_word = @a_word && @in_grid
    @response = @valid_word ? 'Nice' : 'You suck!'
  end
end
