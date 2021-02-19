class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  before_action :check_guest, only: [:create, :edit, :update]

  # パスワードリセット申請ページを表示する
  def new
  end

  # パスワードリセットメールを送る
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user && @user.activated?
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました"
      redirect_to root_url
    else
      flash[:danger] = "このメールアドレスは無効です"
      redirect_to new_password_reset_path
    end
  end

  # パスワードリセットページを表示する
  def edit
  end

  # パスワードを変更する
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードが再設定されました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  private

    # ストロングパラメータ
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # パラメータからユーザーを取得する
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # 期限切れかどうかを確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定の有効期限が切れました、再度やり直して下さい。"
        redirect_to new_password_reset_url
      end
    end
end
