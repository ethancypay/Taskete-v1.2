class Telegram
  def initialize(chat_id, chat_command)
    @chat_id = chat_id
    @chat_command = chat_command
    @bot_reply = nil
    @request_result = false
  end

  def bot_respond
    case @chat_command
    when '/start'
      reply_start
    else
      reply_unrecognized
    end
  end

  private

  def reply_start
    @bot_reply = 'Welcome to Taskete on Telegram. Link your Telegram account by scanning the QR code on the Taskete web app.'
    @request_result = make_http_request('sendMessage', @bot_reply)
  end

  def reply_unrecognized
    @bot_reply = 'Unrecognized command, noob.'
    @request_result = make_http_request('sendMessage', @bot_reply)
  end

  # def self.start(chat_id)
  #   reply = 'Welcome to Taskete on Telegram. Link your Telegram account by scanning the QR code on the Taskete web app.'
  #   request_body = "chat_id=#{chat_id}&text=#{reply}"

  #   make_http_request('sendMessage', request_body)
  # end

  # def self.unrecognized(chat_id)
  #   reply = 'Unrecognized command, noob.'
  #   request_body = "chat_id=#{chat_id}&text=#{reply}"

  #   make_http_request('sendMessage', request_body)
  # end

  # def self.make_http_request(method, request_body)
  def make_http_request(method, request_body)
    uri = URI("https://api.telegram.org/bot#{ENV['TELEBOT_KEY']}/#{method}?#{request_body}")
    response = Net::HTTP.get_response(uri)

    response.is_a?(Net::HTTPSuccess) ? true : false
  end

end
