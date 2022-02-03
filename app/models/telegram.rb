class Telegram
  attr_reader :request_result

  def initialize(chat_id, chat_command = nil)
    # defend against nil input
    @chat_command = if chat_command.nil?
                      nil
                    else
                      parse_command(chat_command)
                    end
    @chat_id = chat_id
    @request_result = false
  end

  def bot_respond
    case @chat_command[0].downcase
    when '/start'
      @chat_command.length != 2 ? start : verify_token
    else
      unrecognized
    end
  end

  def notify_task(title)
    make_http_request('sendMessage',
                      "You have a new task: "\
                      "#{title}")
  end

  private

  # Telegram API request maker (changes @request_result)
  def make_http_request(method, bot_reply)
    request_body = "chat_id=#{@chat_id}&text=#{bot_reply}"
    uri = URI("https://api.telegram.org/bot#{ENV['TELEBOT_KEY']}/#{method}?#{request_body}")
    response = Net::HTTP.get_response(uri)

    @request_result = response.is_a?(Net::HTTPSuccess) ? true : false
  end

  # split command for inputs with 2 parameters
  def parse_command(chat_command)
    chat_command.split(' ', 2)
  end

  # bot commands
  def start
    make_http_request('sendMessage',
                      'Welcome to Taskete on Telegram. '\
                      'Link your Telegram account by scanning the QR code on the Taskete web app.')
  end

  def verify_token
    # getting current_user because not defined without csrf token
    this_user = User.where("auth_token = '#{@chat_command[1]}'")[0]

    if this_user
      this_user.telegram_chat_id = @chat_id
      this_user.save
      make_http_request('sendMessage',
                        'Your Telegram and Taskete accounts have been connected. '\
                        'You will now receive Telegram notifications when you have a task.')
    else
      make_http_request('sendMessage',
                        'Verification failed.')
    end
  end

  def unrecognized
    make_http_request('sendMessage',
                      'Command is unrecognized, noob.')
  end
end
