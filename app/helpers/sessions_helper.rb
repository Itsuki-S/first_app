module SessionsHelper

  # 一時的セッションにユーザーidを保存
  def log_in(user)
    session[:user_id] = user.id
  end

  # セッションにuser.idが入っていればそのidのユーザーを返し、入っていない場合はnilを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 送られてきたユーザー情報がログインしているユーザと等しい場合trueを返す
  def current_user?(user)
    user && user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 永続化セッションの保存
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 永続化セッションの破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # フレンドリーフォワーディング
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # フォワーディング先の保存
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
