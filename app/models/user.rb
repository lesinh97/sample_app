class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/is
  validates :email, format: {with: VALID_EMAIL_REGEX}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.max_lenght_email}
  validates :password, presence: true, length: {minimum: Settings.min_lenght_pass}
  validates :name, presence: true, length: {maximum: Settings.max_lenght_name}
  has_secure_password
end
