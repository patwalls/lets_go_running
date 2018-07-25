class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def log
    return unless text.slice(0,4) == "/run"

    create_user if user_does_not_exist?

    log_run unless already_logged?
  end

  private

  def create_user
    User.create!(
      telegram_id: message[:id],
      first_name: message[:first_name],
      last_name: message[:last_name]
    )
  end

  def log_run
    user = User.find_by(telegram_id: message[:id])

    miles = text.scan(/[-+]?[0-9]*\,?[0-9]+/).join(".").to_f

    run = user.runs.create!(
      distance: miles,
      telegram_message_id: telegram_message_id
    )

    if run
      BotSpeak.new.speak("Logged #{miles.to_f} mile run for #{user.first_name}. Great job!")
    end
  end

  def already_logged?
    Run.find_by(telegram_message_id: telegram_message_id)
  end

  def user_does_not_exist?
    User.where(telegram_id: message[:id]).empty?
  end

  def message
    params[:message][:from]
  end

  def text
    params[:message][:text]
  end

  def telegram_message_id
    params[:message][:message_id]
  end
end
