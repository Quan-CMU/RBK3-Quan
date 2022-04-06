class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Account activation'
  end

  # def password_reset
  #   @greeting = "Hi"

    mail to: "thaiquan25072000@gmail.com"
  end
end
