# Defines a User. A user has a name, email, and a password. Emails must be
# unique and valid.. Passwords must be long enough. Names and emails must be
# within sensible limits.
class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # TODO: This was from https://www.railstutorial.org/
  #       and a better one might exist.

  # Accessible remember token
  attr_accessor :remember_token

  # Emails to downcase
  before_save { self.email = email.downcase }

  # Validations
  validates :name,  presence: true,
                    length: { maximum: 50 }

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true,
                       length: { minimum: 8 }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end

    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember a user for persistent sessions
  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update(remember_digest: nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
