class Api::RespondersController < Api::Controller
  # lookup if the current reporter can be a responder
  def device
    responder = Device.find_by(device_id: params[:device_id]).try(:reporter).try(:responder)
    render json: responder
  end
end
