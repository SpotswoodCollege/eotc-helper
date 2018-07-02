# Describes the behaviour of Users. A User has a name, an email, and a password.
class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # TODO: This was from https://www.railstutorial.org/
  #       and a better one might exist.
  
  # Emails are lowercase
  before_save { self.email = email.downcase }
  
  # Name must be present and up to 50 characters
  validates :name,  presence: true,
                    length: { maximum: 50 }
  
  # Email must be present, unique, a valid email, and up to 255 characters
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  # Users have secure passwords
  has_secure_password

  # Passwords must be present and at least 8 sharacters
  validates :password, presence: true,
                       length: { minimum: 8 }
end
