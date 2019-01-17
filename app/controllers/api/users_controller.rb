class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_request, only: [:register]

  def register
    user = User.new
    user.name = params[:name]
    user.nickname = params[:nickname]
    user.email = params[:email]
    user.password = params[:password]

    if user.save
      render json: { success: true }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

end