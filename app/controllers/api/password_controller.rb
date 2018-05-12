class Api::PasswordController < Api::BaseController
  skip_before_action :authenticate_request, except: [:update]

  def forgot
    return render json: { error: 'Email not present' } if params[:email].blank?

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      UsersMailer.password_reset_email(user.id).deliver_later
      
      render json: { success: true }, status: :ok
    else
      render json: { error: 'Email address not found. Please check and try again' }, status: :not_found
    end
  end

  def validate_token
    errors = []
    errors << 'Email required' if params[:email].blank?
    errors << 'Security code required' if params[:token].blank?

    return render json: { errors: errors }, status: :unprocessable_entity if errors.present?

    user = User.where(email: params[:email], reset_password_token: params[:token]).first

    if user.present? && user.password_token_valid?
      render json: { success: true }
    else
      render json: { error: 'Security code not valid or expired. Try generating a new security code.' }, status: :not_found
    end
  end

  def reset
    errors = []
    errors << 'Email required' if params[:email].blank?
    errors << 'Security code required' if params[:token].blank?

    return render json: { errors: errors }, status: :unprocessable_entity if errors.present?

    user = User.where(email: params[:email], reset_password_token: params[:token]).first

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { success: true }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Token not valid or expired. Try generating a new token.' }, status: :not_found
    end
  end

  def update
    return render json: { error: 'Password not present' }, status: :unprocessable_entity if params[:password].blank?

    if current_user.reset_password!(params[:password])
      render json: { success: true }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

end