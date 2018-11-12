class GamesController < ApplicationController
  require 'open-uri'
  require 'json'
  def new
    @start_time = Time.now
    @letters = Array.new(5) { ('a'..'z').to_a.sample }
  end

  def score
    @new = params[:new]
    @time_taken = params[:time_taken]
    if included?
      if english_word?
        return @message = @new
      else
        return "Not a valid word"
      end
    else
      "Not a valid word"
    end
  end

  def included?
    @new = params[:new]
    @letters = params[:letters]
    @new.chars.all? { |letter| @new.count(letter) <= @letters.split(",").count(letter) }
  end

  def english_word?
    @new = params[:new]
    response = open("https://wagon-dictionary.herokuapp.com/#{@new}")
    json = JSON.parse(response.read)
  end
end
