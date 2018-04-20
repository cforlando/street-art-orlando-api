class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_request

  def register
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password]
    user.anonymous = params[:anonymous] == '1'

    if user.save
      command = AuthenticateUser.call(params[:email], params[:password])
      render json: { auth_token: command.result }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

end