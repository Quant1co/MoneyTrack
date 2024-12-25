class ExpenseIncome < ApplicationRecord
  self.table_name = 'expenses_incomes'
  belongs_to :main_account

  validates :description, presence: true
  validates :sum, numericality: true
  validates :operation_type, inclusion: { in: ['Доход', 'Расход'] }
  validates :date, presence: true
end
