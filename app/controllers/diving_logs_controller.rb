class DivingLogsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :edit, :create, :update, :destroy]

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
    @diving_log = DivingLog.find(params[:id])
    gon.diving_log = @diving_log
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
end
