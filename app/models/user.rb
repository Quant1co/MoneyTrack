class User < ApplicationRecord
  has_secure_password

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[0-9])(?=.*[A-Za-z]).+\z/, message: "должен содержать буквы и цифры" }
end

