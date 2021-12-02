class TelegramsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:bot]

  def bot
    puts 'hello bot'
    binding.pry
  end

end
