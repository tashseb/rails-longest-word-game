require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def score
    @word = params[:word]
    html = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    @word_api = JSON.parse(html)['found']
    @letters = params[:letters]
    @match = match?(@letters, @word)
    session[:current_points] += 1 if @score
  end

  def new
    session[:current_points] = 0 unless session[:current_points]
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def match?(array, word)
    word.split('').all? { |letter| array.include? letter.upcase }
  end
end
