class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def log
    return unless text.slice(0,4) == "/run"

    create_user if user_does_not_exist?

    log_run
  end

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

    user.runs.create!(distance: miles)
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
end
