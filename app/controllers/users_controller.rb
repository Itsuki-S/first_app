class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :check_guest,    only: [:edit, :update, :destroy]

  # ユーザーを作成する
  def new
    @user = User.new
  end
  
  # ユーザーを保存する
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "認証用メールが送信されました"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  # ユーザーページを表示する
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    if @user == current_user
      @diving_logs = @user.diving_logs.all.page(params[:page]).per(10)
    else
      @diving_logs = @user.feed.all.page(params[:page]).per(10)
    end
  end

  # ユーザーの編集ページを表示する
  def edit
    @user = User.find(params[:id])
  end

  # ユーザーの編集を保存する
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールが編集されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # ユーザー一覧を表示する
  def index
    @users = User.where(activated: true).all.page(params[:page])
  end

  # ユーザーを削除する
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーが削除されました"
    redirect_to users_url
  end

  private
    # strong parameters を使うことでセキュリティホールを無くす
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
    end

    # ユーザー自身がアクセスしているかを確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # アドミンユーザーがアクセスしているかを確認する
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
