class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
# ログイン認証されていなければログイン画面へリダイレクトする
# exceptは指定したアクションをbefore_actionの対象から外すもの、今回の場合top,about
  before_action :configure_permitted_parameters, if: :devise_controller?
# もしdeviseの処理を行う場合configure_permitted_parametersというものを実行してねという意味
# このように記述することで、devise利用の機能（ユーザ登録、ログイン認証など）が使われる前
# にconfigure_permitted_parametersメソッドが実行されます。

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  # configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッド
  # を使うことでユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。
end
