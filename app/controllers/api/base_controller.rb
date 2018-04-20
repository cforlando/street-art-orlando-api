class Api::BaseController < ActionController::API
  include ActionController::ImplicitRender
  before_action :authenticate_request
  respond_to? :json  

  attr_reader :current_user
  
  private
  
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render nothing: true, status: 401 unless @current_user
  end

end
