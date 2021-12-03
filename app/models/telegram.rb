class Telegram

  def self.start(chat_id)
    reply = 'Welcome to Taskete on Telegram. Connect your account by scanning the QR code on the Taskete web app.'
    request_body = "chat_id=#{chat_id}&text=#{reply}'"

    make_request('sendMessage', request_body)
  end

  def self.make_request(method, request_body)
    uri = URI("https://api.telegram.org/bot#{ENV['TELEBOT_KEY']}/#{method}?#{request_body}")
    response = Net::HTTP.get_response(uri)

    return unless response.is_a?(Net::HTTPSuccess)

    true
  end

end
