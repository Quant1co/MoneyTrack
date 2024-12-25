class AddOperationTypeToExpensesIncomes < ActiveRecord::Migration[6.1]
  def change
    add_column :expenses_incomes, :operation_type, :string, null: false, default: 'Доход'
  end
end
