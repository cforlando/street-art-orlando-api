class UsersMailer < ApplicationMailer

  def password_reset_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Street Art Orlando Password Reset')
  end

end
