class Telegram

  def self.start(chat_id)
    reply = 'Welcome to Taskete on Telegram. Link your Telegram account by scanning the QR code on the Taskete web app.'
    request_body = "chat_id=#{chat_id}&text=#{reply}"

    make_http_request('sendMessage', request_body)
  end

  # def self.handle(chat_id, command)
  #   reply = ""
  #   case command
  #   when "/start"
  #     reply
  #   when ""
  #     self.handleVote
  #   else

  #   end
  # end

  def self.unrecognized(chat_id)
    reply = 'Unrecognized command, noob.'
    request_body = "chat_id=#{chat_id}&text=#{reply}"
    make_http_request('sendMessage', request_body)
  end

  # def self.testy(chat_id)

  # end

  def self.make_http_request(method, request_body)
    uri = URI("https://api.telegram.org/bot#{ENV['TELEBOT_KEY']}/#{method}?#{request_body}")
    response = Net::HTTP.get_response(uri)

    response.is_a?(Net::HTTPSuccess) ? true : false
  end

end
