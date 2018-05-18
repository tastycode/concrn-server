class AccessTokensController < ApplicationController
  before_action :require_auth, only: %i(destroy current validate)

  def create
    email, password = params.require(%i(email password))
    if user = User.valid_email_login?(email, password)
      user.regenerate_token_with_expiration
      render json: {
        jwt: user.token,
        refresh_token: user.refresh_token
      }, status: :created
    else
      head :forbidden
    end
  end

  def validate
    head :ok
  end

  def destroy
    refresh_token = params.require(:refresh_token)
    if current_user.refresh_token == refresh_token
      current_user.invalidate_token
      current_user.regenerate_refresh_token
      head :no_content
    else
      head :unauthorized
    end
  end

  def refresh
    refresh_token = params.require(:refresh_token)
    user = User.find_by(refresh_token: refresh_token)
    if user.present?
      user.regenerate_token_with_expiration
      render json: {
               jwt: user.token
             }
    else
      head :unauthorized
    end
  end
end
