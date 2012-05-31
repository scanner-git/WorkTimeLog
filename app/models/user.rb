class User < ActiveRecord::Base
	has_secure_password
  attr_accessible :email, :password_digest, :work_day_hour, :password, :password_confirmation

  validates :email, format: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, uniqueness: true
end
