class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        validates :goal, presence: true
        validates :goal_title, presence: true
        validates :end_date, presence: true
        validates :start_date, presence: true

  has_many :saving
         
#  attr_accessor :goal
  #def save_with_goal
    #if valid?
    #  save!
   # end
  # end      
end
