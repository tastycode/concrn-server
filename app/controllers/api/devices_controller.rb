require Rails.root.join('lib/phone_number')
class Api::DevicesController < Api::Controller
  def validate
    # does this device id and phone number match our devices
    if device = Device.find_by(phone: PhoneNumber.normalize(params[:phone]), device_id: params[:device_id])
      render json: { reporter_id: device.reporter_id }
    else
      head :not_found
    end
  end

  def create
    # create a new device with this device id and phone number, trigger verification
    phone = PhoneNumber.normalize(params[:phone])
    result = Authy::PhoneVerification.start(via: "sms", country_code: 1, phone_number: phone)
    if result.ok?
      head :ok
    else
      head :bad_request
    end
  end

  def verify
    phone = PhoneNumber.normalize(params[:phone])
    device = Device.find_or_create_by(phone: PhoneNumber.normalize(params[:phone]), device_id: params[:device_id])
    result = Authy::PhoneVerification.check(verification_code: params[:code], country_code: 1, phone_number: phone)
    if result.ok?
      device.verify
      device.reporter = Reporter.create(name: params[:name])
      device.save
      render json: { reporter_id: device.reporter_id }
    else
      Rails.logger.info(result)
      head :bad_request
    end
  end
end
