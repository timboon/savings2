class PagesController < ApplicationController
    
    def home
        
     if user_signed_in?
        @goal = User.where(id: current_user.id).pluck(:goal)
        @goal_amount = @goal.last
        @progress = Saving.where(user_id: current_user.id).sum(:amount)
        
        goal=@goal_amount
        progress=@progress
        @percent = (progress*100)/goal
        goal_title = User.where(id: current_user.id).pluck(:goal_title)
        @goal_title = goal_title.last
    else    
end
        
    end
    
end
