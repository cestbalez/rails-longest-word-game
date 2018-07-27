require "open-uri"

class GamesController < ApplicationController
  def new
    @letters=Array.new(10, '')
    @letters.map! { ('a'..'z').to_a[rand(26)].upcase }
  end

  def score
    @answer = params[:word].downcase
    @letters = params[:letters].downcase
    @response = ''
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    json_hash = JSON.parse(open(url).read)
    @session[:score] = @json_hash["length"]
    raise
    testing = nil
    @answer.split("").each do |letter|
      if @letters.include?(letter)
        @letters[@letters.index(letter)] = ""
        testing = true
      else
        testing = false
      end
    end


    if json_hash["found"] == true
      if testing
        @response = "Congratulations, #{@answer} is an english word!"
      else
        @response = "Sorry, but #{@answer} can't be build out of the array"
      end
    else
      @response = "Sorry, but #{@answer} does not seem to be a valid English word..."
    end
  end
end
