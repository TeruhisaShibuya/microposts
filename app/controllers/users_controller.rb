class UsersController < ApplicationController
  
  before_action :logged_in_user, only:[:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new   #モデルは大文字
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])  #idに対応するユーザー情報をひろう
  end
  
  def update   #attribute 更新メソッド 更新されたら userページへ飛ばす　ダメならeditページへそのまま
    @user = User.find_by_id(params[:id]) 
    if @user.update_attributes(user_params)
      redirect_to @user
      flash[:success] = "プロフィールの更新が完了しました"
      else
      render 'edit'
    end
  end
  
    private   #簡単にはアクセス出来ないようにしたいものはprivateより下に記載
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def logged_in_user  #ログイン済みかどうか?? アクセス簡易のプロテクトはprivate以下に記載 まわりから見えないように！
      unless logged_in?
        flash[:danger] = "まずはログインしてください"
        redirect_to login_url
      end
    end
end
