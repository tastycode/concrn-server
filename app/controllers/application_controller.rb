class ApplicationController < ActionController::API
  TOKEN_TIMEOUT = 3.days

  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_user

  protected

  def require_auth
    authenticate_token || head(:unauthorized)
  end


  def respond_with_errors(model)
    errors = ErrorSerializer.serialize(model)
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def authenticate_token
    @current_user ||= authenticate_with_http_token do |token, options|
      User.where("token_issued_at > ?", TOKEN_TIMEOUT.ago).find_by(token: token)
    end
  end
end
