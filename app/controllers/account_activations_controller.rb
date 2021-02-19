class AccountActivationsController < ApplicationController
  
  # アカウントを有効化する
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "アカウントが認証されました！ Diver's logへようこそ！"
      redirect_to user
    else
      flash[:danger] = "無効な認証トークンです"
      redirect_to root_path
    end
  end

end