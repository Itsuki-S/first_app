class DivingLogsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :check_guest,    only: [:create, :update, :destroy]
  # ログの作成ページを表示する
  def new
    @diving_log = current_user.diving_logs.build
  end
  
  # ログを作成する
  def create
    @diving_log = current_user.diving_logs.build(diving_log_params)
    if @diving_log.save
      flash[:success] = "ログが作成されました！"
      redirect_to current_user
    else
      render 'new'
    end
  end

  # ログを表示する
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

  # ログの編集ページを表示する
  def edit
  end

  # ログの編集を適用する
  def update
    @diving_log.update_attributes(diving_log_params)
    if @diving_log.save
      flash[:success] = "ログが編集されました！"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  # ログを削除する
  def destroy
    @diving_log.destroy
    flash[:success] = "ログが削除されました"
    redirect_to current_user
  end

  private
    # ストロングパラメータ
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

    # ログの所有者がアクセスしているかを確認する
    def correct_user
      @diving_log = current_user.diving_logs.find_by(id: params[:id])
      if @diving_log.nil?
        flash[:warning] = "無効なリクエストです"
        redirect_to root_path
      end
    end
end
