class ChangeSavingstoDate < ActiveRecord::Migration[5.0]
  def change
   # change_column :savings, :week, :date
    change_column :savings, :week, 'date USING CAST(week AS date)'
  end
end
    
