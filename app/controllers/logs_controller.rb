class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def log
    return unless text&.slice(0,4) == "/run"

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

    command = text.slice(4,1000)

    distance, duration = command.split("/")

    miles = distance.scan(/[-+]?[0-9]*\,?[0-9]+/).join(".").to_f

    if duration
      duration = convert_duration(duration)
    end

    run = user.runs.create!(
      distance: miles,
      duration: duration,
      telegram_message_id: telegram_message_id,
    )

    if run
      BotSpeak.new.speak("Logged #{miles.to_f} mile run#{with_duration(run)} for #{user.first_name}. Great job!")
    end
  end

  def already_logged?
    Run.find_by(telegram_message_id: telegram_message_id)
  end

  def with_duration(run)
    if run.duration
      " (#{run.friendly_duration})"
    else
      ""
    end
  end

  def user_does_not_exist?
    User.where(telegram_id: message[:id]).empty?
  end

  def convert_duration(duration)
    duration.strip.split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
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
