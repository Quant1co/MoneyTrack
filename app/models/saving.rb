# app/models/saving.rb
class Saving < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :target_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :current_balance, numericality: { greater_than_or_equal_to: 0 }

  # Метод для пополнения копилки
  def deposit(amount)
    raise ArgumentError, "Сумма должна быть больше 0" if amount <= 0

    self.current_balance += amount
    save!
  end

  # Метод для снятия средств
  def withdraw(amount)
    raise ArgumentError, "Сумма должна быть больше 0" if amount <= 0
    raise ArgumentError, "Недостаточно средств" if current_balance < amount

    self.current_balance -= amount
    save!
  end

end