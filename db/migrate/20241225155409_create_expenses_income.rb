class CreateExpensesIncome < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses_incomes do |t|
      t.decimal :sum, precision: 15, scale: 2, null: false
      t.string :description
      t.date :date, null: false
      t.references :main_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
