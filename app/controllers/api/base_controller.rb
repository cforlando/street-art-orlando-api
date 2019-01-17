class Api::BaseController < ActionController::API
  include ActionController::ImplicitRender
  before_action :authenticate_request

  attr_reader :current_user
  
  private
  
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Unauthorized user' }, status: :unauthorized unless @current_user
  end

  def set_current_user
    @current_user = AuthorizeApiRequest.call(request.headers).result
  end

  def device_identifier
    request.headers['DEVICE-IDENTIFIER']
  end

end
