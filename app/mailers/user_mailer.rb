class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mail_subject_actived")
  end

  def password_reset
    @greeting = t "hello"
    mail to: "to@example.org"
  end
end
