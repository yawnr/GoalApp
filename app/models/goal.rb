class Goal < ActiveRecord::Base

  validates :goal_text, :user_id, presence: true

  belongs_to :user
  
end
