class MainAccount < ApplicationRecord
  belongs_to :user
  has_many :expenses_incomes, class_name: 'ExpenseIncome'

  validates :current_balance, numericality: { greater_than_or_equal_to: 0 }
end
