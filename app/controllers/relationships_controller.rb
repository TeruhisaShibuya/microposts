class RelationshipsController < ApplicationController
before_action :logged_in_user

  def create #フォローするユーザーのidを受取 そのidユーザーを引数にしてuses_controlerのfollowメソッドを実行している
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy  #ログインアカウントのリレイションを確認 フォローしている対象を引数にして、users controllerのunfollowメソッドを実行
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
  

  
  
end