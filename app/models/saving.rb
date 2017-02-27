class Saving < ApplicationRecord
        validates :week, presence: true
        validates :amount, presence: true
    belongs_to :user
    
end
