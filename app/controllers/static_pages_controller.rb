class StaticPagesController < ApplicationController
   def home
     if logged_in?
     @micropost = current_user.microposts.build  #build=newだが buildはuser_idが紐づく
     @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
     end
   end
end

#includes(:user) →→つぶやきのユーザー情報をプリロード処理するためのメソッド