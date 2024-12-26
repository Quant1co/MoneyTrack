class Transaction < ApplicationRecord
  belongs_to :account

  validates :name, :amount, :transaction_type, presence: true
  validates :transaction_type, inclusion: { in: %w[income expense] }

end
