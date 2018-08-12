class DispatchesController < ApplicationController
  def update
    dispatch = Dispatch.find(params[:id])
    dispatch = Dispatch::Commands::Update.perform(dispatch: dispatch, updates: dispatch_params)
    if dispatch.errors.none?
      render json: report
    else
      respond_with_errors(dispatch)
    end
  end

  def dispatch_params
    params.require(:data).permit(:type, {
      attributes: %i(status)
    })
  end

  def authenticate_twilio_request
    secret_key = Secrets.twilio_access_key
    authenticated = authenticate_with_http_token do |token, options|
      return secret_key == token
    end
    if !authenticated
      return head :unauthorized
    end
  end
end
