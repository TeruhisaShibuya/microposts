class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)  
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  def destroy       #ログアウト処理
    session[:user_id] = nil　　     #セッション破棄
    redirect_to root_path
  end
end




#params[:session]部分にloginフォームに入力したパラメータが入っている
#1行目で入力emailを元にユーザーを検索 2行目でパスワードが一致しているかを確認
#