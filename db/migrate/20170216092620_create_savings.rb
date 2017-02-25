class CreateSavings < ActiveRecord::Migration[5.0]
  def change
    create_table :savings do |t|
      t.integer :user_id
      t.date :week
      t.integer :amount
      t.timestamps
    end
  end
end
