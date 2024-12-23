class CreateAdvices < ActiveRecord::Migration[8.0]
  def change
    create_table :advices do |t|
      t.text :content

      t.timestamps
    end
  end
end
