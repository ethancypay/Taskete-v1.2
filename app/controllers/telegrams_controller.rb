require 'net/http'

class TelegramsController < ApplicationController
  #Telegram webhook API doesn't return token
  skip_before_action :verify_authenticity_token, only: [:bot]

  def bot
    req_success = false
    chat_id = params['message']['chat']['id']
    chat_command = params['message']['text']

    if chat_command == '/start'
      req_success = Telegram.start(chat_id)
    else
      puts 'lol'
    end

    return unless req_success == true

    # return header (200 OK) if reply success
    respond_to do |format|
      format.html { head :ok }
    end
  end

end
