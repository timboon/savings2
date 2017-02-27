Things I still have to do
    * After adding savings redirect to same page to allow more than one input
    * Home Pages should show overall progress to goal using JS for aesthetics -done
    * Individual view savings page should should detailed breakdown of savings -done
    * User should be able to select the start and end date of savings goal -done
    * User should be able to give a title to the name of the goal -done
    * Savings should be cumulative -done
    
    old goal chart
    
    @goal_data = Array.new(27) {|i| (i+1) * (@goal.last)/27}
    
      #@data_sorted[i][0] = @data_sorted[i][0].strftime('%F')
    #@data_sorted[i][0] = @data_sorted[i][0].to_s
  


 heroku pg:reset DATABASE

class ChangeSavingstoDate < ActiveRecord::Migration[5.0]
  def change
   # change_column :savings, :week, :date
    change_column :savings, :week, 'date using cast(week as date)'
  end
end
    
/railsapp/db/migrate/20170216092620_create_savings.rb.

20170221025052_change_savingsto_date.rb