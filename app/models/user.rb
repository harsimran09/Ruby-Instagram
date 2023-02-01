class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  # Will return an array of follow instances where (A,B(current user)), (C,B), (D,B)
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow", dependent: :destroy

  # Will return an array of (A,C,D) users who follow B(current user)
  has_many :followers, through: :received_follows, source: :follower
# ------------------------------------------------------------------
  # returns an array of follow objects where (B,A), (B,C), (B,D) 
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  
  # returns an array of (A,C,D)-> users who are followed by B(current user)
  has_many :followings, through: :given_follows, source: :followed_user

  def follow(other_user) 
    self.given_follows.create(followed_user_id: other_user.id)
  end
 
# Unfollows a user.
  def unfollow(other_user)
      self.given_follows.find_by(followed_user_id: other_user.id).destroy
  end
 
# Returns true if the current user is following the other user.
  def following_c(other_user)
      following.include?(other_user)
  end
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
end
