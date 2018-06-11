class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/is
  attr_accessor :remember_token
  validates :email, format: {with: VALID_EMAIL_REGEX}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.max_lenght_email}
  validates :password, presence: true, length: {minimum: Settings.min_lenght_pass}, allow_nil: true
  validates :name, presence: true, length: {maximum: Settings.max_lenght_name}
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end
end
