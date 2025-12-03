class User < ApplicationRecord
  has_secure_password # bcrypt - hashes password and allows us to use password and password_confirmation and adding validations for password and password_confirmation
  validates :email, presence: true, uniqueness: true
end
