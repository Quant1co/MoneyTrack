class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.decimal :amount
      t.string :transaction_type

      t.timestamps
    end
  end
end