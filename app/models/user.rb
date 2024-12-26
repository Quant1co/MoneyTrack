class User < ApplicationRecord
  has_secure_password

  has_one :account, dependent: :destroy
  after_create :create_default_account

  before_save :format_phone_number



  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A8\(\d{3}\)\d{3}-\d{4}\z/, message: "должен быть в формате 8(XXX)XXX-XXXX" }
  validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[0-9])(?=.*[A-Za-z]).+\z/, message: "должен содержать буквы и цифры" }

  private

  def format_phone_number
    if phone.present? && phone.gsub(/\D/, '').match(/\A8\d{10}\z/)
      digits = phone.gsub(/\D/, '')
      self.phone = "8(#{digits[1..3]})#{digits[4..6]}-#{digits[7..10]}"
    else
      errors.add(:phone, 'неверный формат')
      throw(:abort)
    end
  end

  def create_default_account
    Account.create(user: self, balance: 1000.0)
  end


end
