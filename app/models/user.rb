# Defines a User. A user has a name, email, and a password. Emails must be
# unique and valid.. Passwords must be long enough. Names and emails must be
# within sensible limits.
class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # TODO: This was from https://www.railstutorial.org/
  #       and a better one might exist.

  before_save { self.email = email.downcase }

  validates :name,  presence: true,
                    length: { maximum: 50 }

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true,
                       length: { minimum: 8 }
end
