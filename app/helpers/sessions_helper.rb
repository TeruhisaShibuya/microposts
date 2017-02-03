module SessionsHelper
    def current_user
        @current_user ||=User.find_by(id: session[:user_id])
    end
    
    def logged_in?
      !!current_user
    end
    
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end


# ||=左の値がfalse or nilなら右の値の代入を実施する
#find by メソッド ：引数で見つける 見つからない場合はnil返す

#logged in メソッド  !!否定演算子を２回使用したもの　 右側に続く値が存在する場合はfolse !!で反転してtrue
#ログインが必要な画面にアクセスしようとした場合にログイン画面に一度飛ばす。よくある機能 