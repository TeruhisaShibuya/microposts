class User < ActiveRecord::Base
     before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :microposts   #1対多の関係 userから見たらマイクロソフトは無数にある
    
    
#他人のフォローしている人の関係と表示の作成を以下で行う

#他人のフォローしている人の関係は following_relationships とする　　　ここは言葉がややこしくて理解するのが大変〜！！！
     has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
#他人のフォローしているユーザーは following_users とする following_relationships情報を通して取得 ソースは他人の"followed"部分 
  has_many :following_users, through: :following_relationships, source: :followed
  
  
#他人のフォローされている関係は follower_relationships とする  
    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
#他人のフォローされているユーザーは follower_users とする                                    
  has_many :follower_users, through: :follower_relationships, source: :follower
    
  # 他のユーザーをフォロー  find_or_create_byで一つのメソッド 引数のパラメータと一致するものを1件取得 
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end


  # フォローしているユーザーをアンフォロー  リレイションシップからフォローidを探す。フォローしているならする関係を破壊する
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？  following_usersに含まれているかのチェック includeでメソッド?
  def following?(other_user)
    following_users.include?(other_user)
  end
end
