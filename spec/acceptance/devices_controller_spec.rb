require 'acceptance_helper'

resource 'Devices' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  route '/devices', 'Device Management' do
    attribute :phone, "Device's phone number", required: true
    attribute :identifier, "Device ID", required: true

    post 'Register a device' do
      let(:request) do
        {
          phone: '4156031994',
          identifier: '6D92078A-8246-4BA4-AE5B-76104861E7DC'
        }
      end

      example 'Initiates authy registration' do
        allow(Authy::PhoneVerification)
          .to receive(:start).with(via: "sms", country_code: 1, phone_number: "4156031994")
          .and_return(double(ok?: true))
        do_request(request)
        expect(status).to eq(200)
      end
    end
  end

  route '/devices/verify', 'Verify a device' do
    attribute :phone, "Device's phone number", required: true
    attribute :identifier, "Device ID", required: true
    attribute :code, "SMS Verification Code", required: true

    post 'Verify a device' do
      let(:request) do
        {
          phone: '4156031994',
          identifier: '6D92078A-8246-4BA4-AE5B-76104861E7DC',
          code: '5812'
        }
      end

      example 'Returns a token' do
        allow(Authy::PhoneVerification)
          .to receive(:check).with(verification_code: request[:code], country_code: 1, phone_number: request[:phone])
          .and_return(double(ok?: true))
        do_request(request)
        expect(json["jwt"]).to be_present
        expect(json["refresh_token"]).to be_present
      end
    end
  end
end
