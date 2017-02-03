class Micropost < ActiveRecord::Base
    belongs_to :user  #1つだけのユーザーに紐づく 多 対 1の関係
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }    
end
