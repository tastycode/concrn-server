class Api::RespondersController < Api::Controller
  # lookup if the current reporter can be a responder
  def device
    responder = Device.find_by(device_id: params[:device_id]).try(:reporter).try(:responder)
    render json: responder
  end

  def update
    responder = Responder.find(params[:id])
    responder_params = params.permit(:available, :lat, :long)
    responder.update_attributes(responder_params)
    render json: responder
  end
end
