class CreateSavings < ActiveRecord::Migration[8.0]
  def change
    create_table :savings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.decimal :target_amount, precision: 10, scale: 2, default:0.0,null:false
      t.decimal :current_balance, precision: 10, scale: 2, default: 0.0,null:false

      t.timestamps
    end
  end
end
