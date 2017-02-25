class AddGoalTitletoUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :goal_title, :string

  end
end
