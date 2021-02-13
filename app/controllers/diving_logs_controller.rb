class DivingLogsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def new
    @diving_log = current_user.diving_logs.build
  end
  
  def create
    @diving_log = current_user.diving_logs.build(diving_log_params)
    if @diving_log.save
      flash[:success] = "ログが作成されました！"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    diving_log = DivingLog.find(params[:id])
    if diving_log.published == false && diving_log.user != current_user
      flash[:warning] = "このログは公開されていません"
      redirect_to root_path
    else
      @diving_log = diving_log
      gon.diving_log = @diving_log
    end
  end

  def edit
  end

  def update
    @diving_log.update_attributes(diving_log_params)
    if @diving_log.save
      flash[:success] = "ログが編集されました！"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    @diving_log.destroy
    flash[:success] = "ログが削除されました"
    redirect_to current_user
  end

  private
    def diving_log_params
      params.require(:diving_log).permit(
        :dive_number,
        :address,
        :latitude,
        :longitude,
        :point,
        :entry,
        :entry_time,
        :exit_time,
        :entry_bar,
        :exit_bar,
        :air_temperature,
        :water_temperature,
        :condition,
        :transparency,
        :ave_depth,
        :max_depth,
        :equipment,
        :comment,
        :published,
        {images: []}
      )
    end

    def correct_user
      @diving_log = current_user.diving_logs.find_by(id: params[:id])
      if @diving_log.nil?
        flash[:warning] = "無効なリクエストです"
        redirect_to root_path
      end
    end
end
