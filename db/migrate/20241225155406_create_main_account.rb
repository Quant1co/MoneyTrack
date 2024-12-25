class CreateMainAccount < ActiveRecord::Migration[7.0]
  def change
    create_table :main_accounts do |t|
      t.decimal :current_balance, precision: 15, scale: 2, default: 0.0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
