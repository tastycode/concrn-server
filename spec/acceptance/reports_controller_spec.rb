require 'acceptance_helper'

resource 'Reports' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  route '/reports', 'Reports' do

    parameter :lat, "Latitude", required: true, scope: [:data, :attributes]
    parameter :long, "Longitude", required: true, scope: [:data, :attributes]
    parameter :address, "Address", required: true, scope: [:data, :attributes]
    parameter :reporter_notes, "Reporter's Notes", required: true, scope: [:data, :attributes]
    parameter :is_harm_immediate, "Is Harm Immediate?", required: true, scope: [:data, :attributes]
    parameter :zip, "Address Zip", scope: [:data, :attributes]
    parameter :google_place_id, "Google Place ID", scope: [:data, :attributes]

    post 'Creating a report' do
      header 'Authorization', :authorization
      let(:user) { build(:user) }
      let(:authorization) { "Bearer #{user.token}" }
      let(:lat) { 30 }
      let(:long) { 90 }
      let(:address) { "2729 Rampart St, New Orleans, LA 70117" }
      let(:reporter_notes) { "Joe doesn't look well today, he's taking apart his car looking for 'bugs'" }
      let(:is_harm_immediate) { false }
      let(:zip) { "70117" }
      let(:source) { "Concrn iOS 1.2" }

      let(:request) do
        {
          data: {
            type: 'report',
            attributes: {
              lat: lat,
              long: long,
              address: address,
              reporter_notes: address,
              is_harm_immediate: is_harm_immediate,
              zip: zip,
              source: source
            }
          }
        }
      end

      before do
        user.regenerate_token_with_expiration
        user.regenerate_refresh_token
      end

      example 'Creates a report' do
        do_request(request)
        expect(status).to eq(200)
        expect(json["data"]["id"].to_i).to eq(Report.last.id)
      end

    end
  end
end
