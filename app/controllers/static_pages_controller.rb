class StaticPagesController < ApplicationController
   def home
     @micropost = current_user.microposts.build if logged_in?  #build=newだが buildはuser_idが紐づく
   end
end

