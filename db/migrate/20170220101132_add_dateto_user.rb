class AddDatetoUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :start_date, :date
    add_column :users, :end_date, :date
  end
end
