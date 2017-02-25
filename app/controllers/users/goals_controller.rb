class Users::RegistrationsController < Devise::RegistrationsController
 
 
 
 # Extend default Devise gem behaviour, so that users signing up with 
 # the Pro account (plan id 2), save with a Stripe subscription function
 # Otherwise Devise signs up user as usual (basic users)
 
  def create
    super do |resource|
   
     goalsave = params[:goal]
     
    resource.save_with_goal
    end
  end



end