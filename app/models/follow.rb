class Follow < ApplicationRecord
    # The user following 
  belongs_to :follower, foreign_key: :follower_id, class_name: "User"

  # The user being followed
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: "User"
end
