class AddDatetoUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :start_date, :string
    add_column :users, :end_date, :string
  end
end
