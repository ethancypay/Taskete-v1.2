require 'net/http'

class TelegramsController < ApplicationController
  #Telegram webhook API doesn't return token
  skip_before_action :verify_authenticity_token, only: [:bot]

  def bot
    # reply with POST request, header (200 OK)

    uri = URI("https://api.telegram.org/#{ENV['TELEBOT_KEY']}/sendMessage")
    req = Net::HTTP::Post.new(uri)
    puts res.body

    respond_to do |format|
      format.html { head :ok }
      # format.json { render json: { data: "hello world"}, status: :ok }
    end
  end

end
