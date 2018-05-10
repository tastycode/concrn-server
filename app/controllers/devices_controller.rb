class DevicesController  < ApplicationController
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
    phone = ::PhoneNumber.normalize(params[:phone])
    result = Authy::PhoneVerification.check(verification_code: params[:code], country_code: 1, phone_number: phone)
    if result.ok?
      device = Device.find_or_create_by(identifier: params[:identifier])
      device.user = User.find_or_create_by(phone: phone)
      device.user.regenerate_token_with_expiration
      device.save
      render json: {
            jwt: device.user.token,
            refresh_token: device.user.refresh_token
      }, status: :created
    else
      head :bad_request
    end
  end
end
