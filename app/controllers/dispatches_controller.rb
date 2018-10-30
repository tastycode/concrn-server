class DispatchesController < ApplicationController
  def create
    report = Report.find(params[:data][:attributes][:report_id])
    responder = Responder.find_by(user_id: params[:data][:attributes][:responder_user_id])
    attempt_dispatch = Report::Commands::AttemptDispatch.perform(report: report, responder: responder)
    render(json: {
      data: {
        id: attempt_dispatch.dispatch.id,
        type: 'dispatches'
      }
    })
  end

  def update
    dispatch = Dispatch.find(params[:id])
    dispatch = Dispatch::Commands::Update.perform(dispatch: dispatch, updates: dispatch_params[:attributes])
    if dispatch.errors.none?
      render json: dispatch
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
