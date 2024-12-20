class User < ApplicationRecord
  has_secure_password
  has_many :favorites

  has_one :saving ,dependent: :destroy

  after_create :create_default_saving

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[0-9])(?=.*[A-Za-z]).+\z/, message: "должен содержать буквы и цифры" }

  def create_default_saving
    build_saving(
      title: "Моя Копилка",
      target_amount: 0.00,
      current_balance: 0.00
    ).save
  end

end
