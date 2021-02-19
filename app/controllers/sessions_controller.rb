class SessionsController < ApplicationController

  #ログインページの表示
  def new
  end

  #ログイン
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash[:warning] = "メールを確認してアカウントの認証を済ませて下さい"
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスかパスワードが正しくありません'
      render 'new'
    end
  end

  #ログアウト
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  #ゲストユーザーとしてログインする
  def guest
    @user = User.find_by(email: "guest@diver.ne.jp")
    log_in @user
    forget(@user)
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_back_or root_url
  end
end
