require 'net/http'

class TelegramsController < ApplicationController
  #Telegram webhook API doesn't return token
  skip_before_action :verify_authenticity_token, only: [:bot]

  def bot
    chat_id = params['message']['chat']['id']
    chat_command = params['message']['text']

    request_body = "?chat_id=#{chat_id}&text=You said '#{chat_command}'"

    uri = URI("https://api.telegram.org/bot#{ENV['TELEBOT_KEY']}/sendMessage#{request_body}")
    res = Net::HTTP.get_response(uri)

    # return header (200 OK) if reply success
    if res.is_a?(Net::HTTPSuccess)
      respond_to do |format|
        format.html { head :ok }
      end
    end
  end

end
