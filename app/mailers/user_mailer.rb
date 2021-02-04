class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Diver's logのアカウント認証用メールです"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Diver's logのパスワード再設定用メールです"
  end
end
