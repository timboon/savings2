class ChangeSavingstoDate < ActiveRecord::Migration[5.0]
  def change
   # change_column :savings, :week, :date
    change_column :savings, :week, 'date using cast(week as date)'
  end
end
    
