class TelegramsController < ApplicationController
  # Telegram webhook API doesn't return token
  skip_before_action :verify_authenticity_token, only: [:bot]

  def bot
    # Extracting from params
    chat_id = params['message']['chat']['id']
    chat_command = params['message']['text']

    if chat_command == '/start'
      return respond if Telegram.start(chat_id)
    end

    respond if Telegram.unrecognized(chat_id)
  end

  private

  def respond
    respond_to do |format|
      format.html { head :ok }
    end
  end
end
