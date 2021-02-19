class ApplicationController < ActionController::Base
  include SessionsHelper

  private
    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインして下さい"
        redirect_to login_url
      end
    end

    # ゲストユーザーとしてアクセスしているかを確認する
    def check_guest
      email = current_user.email || params[:password_reset][:email].downcase
      if email == "guest@diver.ne.jp"
        flash[:warning] = "ゲストユーザによる無効なリクエストです"
        redirect_to root_url
      end
    end
end
