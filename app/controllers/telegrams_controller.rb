class TelegramsController < ApplicationController
  # Telegram webhook API doesn't return token
  skip_before_action :verify_authenticity_token, only: [:bot]

  def bot
    # Extracting from params
    chat_id = params['message']['chat']['id']
    chat_command = params['message']['text']

    telegram_reply = Telegram.new(chat_id, chat_command)
    telegram_reply.bot_respond

    respond_to_telegram if telegram_reply.request_result
  end

  def link
    qrcode = RQRCode::QRCode.new("http://github.com/")
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )

    respond_to do |format|
      format.text { render inline: 'hihi' }
    end
  end

  def unlink

  end

  private

  def respond_to_telegram
    respond_to do |format|
      format.html { head :ok }
    end
  end
end
