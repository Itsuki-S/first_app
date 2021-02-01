class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Diver's log!"
      log_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private
  #strong parameters を使うことでセキュリティホールを無くす
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
