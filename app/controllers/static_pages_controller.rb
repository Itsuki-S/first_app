class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @diving_logs = current_user.feed.all.page(params[:page])
    end
  end

  def about
  end
end
