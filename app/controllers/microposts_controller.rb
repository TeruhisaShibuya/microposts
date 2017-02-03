class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]  #アクション前にapplication controllerのloggedinメソッドを実行 クリエイトの時だけね
    
    def create
      @micropost = current_user.microposts.build(microposts_params)  #常に後ろから読むイメージ 
      if @micropost.save                                            #マイクロポストのパラーメーターを受け取る
      flash[:success] = "Micropost created!"                         #現在のユーザーに紐付け
      redirect_to root_url                                           #インスタンス変数へ入れる
      else
       render 'static_pages/home'
      end
    end
    
    def destroy
      @micropost = current_user.microposts.find_by(id: params[:id]) #ユーザーID＆ポストID
      return redirect_to root_url if @micropost.nil? #自分のでなければroot行き！！
      @micropost.destroy
      flash[:success] = "マイクロポストを削除しました"
      redirect_to request.referrer || root_url
    end

    
    private
    
    def microposts_params  
        params.require(:micropost).permit(:content)
    end
end

    

#paramsメソッドで、マイクポストのコンテンツを安全に受け取る