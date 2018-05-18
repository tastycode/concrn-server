require 'acceptance_helper'
resource 'Tokens' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  route '/tokens', 'Token management' do
    attribute :phone, "Device's phone number", required: true

    delete 'Logging out' do
      header 'Authorization', :authorization
      let(:user) { build(:user) }
      let(:authorization) { "Bearer #{user.token}" }

      let(:request) do
        {
          refresh_token: user.refresh_token
        }
      end

      before do
        user.regenerate_token_with_expiration
        user.regenerate_refresh_token
      end

      example 'Resets token' do
        do_request(request)
        expect(status).to eq(204)
      end
    end

    post 'Logging in via email' do
      let(:user) { create(:user) }
      let(:request) do
        {
          email: user.email,
          password: "securepassword"
        }
      end

      example 'Provides a token' do
        do_request request
        expect(json["jwt"]).to be_present
      end
    end
  end

  route '/tokens/refresh', 'Refresh a token' do
    post 'Refreshing a token' do
      let(:user) { build(:user) }
      let(:request) do
        {
          refresh_token: user.refresh_token
        }
      end

      before do
        user.regenerate_token_with_expiration
        user.regenerate_refresh_token
      end

      example 'Refreshes a token' do
        do_request(request)
        expect(json["jwt"]).to be_present
      end
    end
  end
end
