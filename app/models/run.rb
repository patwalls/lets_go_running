class Run < ApplicationRecord
  belongs_to :user

  def self.group_by_day
    all.group_by(&:group_by_criteria)
  end

  def group_by_criteria
    created_at.in_time_zone('Eastern Time (US & Canada)').to_date.to_s(:db)
  end

  def readable_time_of_day
    created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%I:%M %p")
  end

  def friendly_duration
    return unless duration
    Time.at(duration).utc.strftime("%H:%M:%S")
  end
end
