class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_request

  def register
    if params[:anonymous].present?
      @user = User.new
      @user.email = params[:email]
      @user.password = params[:password]
      @user.password_confirmation = params[:password]
      @user.anonymous = true

      if @user.save
        command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          render json: { auth_token: command.result }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      else
        render json: @user.errors, status: :unprocessable_entity
      end

      return
    end

    render json: { error: 'unauthorized' }, status: :unauthorized
  end

end