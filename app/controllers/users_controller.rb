class UsersController < ApplicationController
  
  before_action :logged_in_user, only:[:index]
  
 def show #view my profail画面
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)  #新基準に表示するメソッド
 end
  
  def new
    @user = User.new   #モデルは大文字
  end
  
  def create
    @user = User.new(user_params) #このメソッドはprivate以下で定義
    if @user.save                 #データベースへ保存
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def index             #Users画面
    @users = User.all
  end
  
  
  def followings  #フォローしているユーザーの一覧メソッド
    @title = "Following"
    @user = User.find(params[:id])  #とあるidのユーザーユーザー情報をインスタンスへ代入
    @users = @user.following_users   #そのユーザーがフォローしているユーザーを取り出す
    render 'show_follow'
  end
  
  def followers  #フォローされているユーザーの一覧表示メソッド
    @title = "Followers"   #クリックした方に応じて表示画面のタイトルを変える方法
    @user  = User.find(params[:id])  #URLに応じてidを引っ張る
    @users = @user.follower_users
    render 'show_follow'
  end
  
  
    private  #praivate以下はストロングパラメーター セキュリティ向上
    
    def user_params
      params.require(:user).permit(:name, :email, :password,     
                                   :password_confirmation)        
    end                                                          
end


#このメソッドを一言で言うと→フォーム上で入力されたnameやemailといった情報を受け取る事を許可するメソッド
#paramsメソッド→フォームデータをコントローラー内部に受け取る事が出来る
# http上のパラメーターのうち、「:user」というキーを持ち「:name :emailなどのキーを持つハッシュ形式であること」を確かめる