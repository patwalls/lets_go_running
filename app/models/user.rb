class User < ApplicationRecord
  has_many :runs

  def name
    "#{first_name} #{last_name}"
  end
end
