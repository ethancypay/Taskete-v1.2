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
    current_user.regenerate_auth_token if current_user.auth_token.nil?
    qrcode = RQRCode::QRCode.new("https://t.me/Taskete_bot?start=#{current_user.auth_token}")
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 8,
      standalone: true,
      use_path: true
    )

    respond_to do |format|
      format.text { render html: svg.html_safe }
      # format.text { render partial: 'shared/telegramQR', formats: [:html] }
    end
  end

  # def unlink

  # end

  private

  def respond_to_telegram
    respond_to do |format|
      format.html { head :ok }
    end
  end
end
