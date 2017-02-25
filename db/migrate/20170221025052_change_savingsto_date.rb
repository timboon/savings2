class ChangeSavingstoDate < ActiveRecord::Migration[5.0]
  def change
    change_column :savings, :week, :date
  end
end
    
