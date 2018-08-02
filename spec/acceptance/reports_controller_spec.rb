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
      let(:lat) { 30 }
      let(:long) { 90 }
      let(:address) { "2729 Rampart St, New Orleans, LA 70117" }
      let(:reporter_notes) { "Joe doesn't look well today, he's taking apart his car looking for 'bugs'" }
      let(:is_harm_immediate) { false }
      let(:zip) { "70117" }
      before do
        Rails.application.secrets.twilio = {access_key: "test"}
      end

      context 'via twilio auth' do
        let(:source) { "sms" }
        let(:authorization) { "Bearer #{Rails.application.secrets.twilio[:access_key]}" }
        header 'Authorization', :authorization
        let(:request) do
          {
            data: {
              type: 'report',
              attributes: {
                lat: lat,
                long: long,
                address: address,
                reporter_notes: address,
                reporter_phone: '+14178930980',
                zip: zip,
                source: source
              }
            }
          }
        end

        example 'Creates a report' do
          do_request(request)
          expect(status).to eq(200)
          expect(json["data"]["id"].to_i).to eq(Report.last.id)
        end

        context 'Creating a report without a zip' do
          before do
            request[:data][:attributes][:zip] = nil
          end

          example 'Creates a report while queueing a zip resolving job' do
            expect {
              do_request(request)
            }.to enqueue_job(Report::ResolveZipJob)
          end
        end
      end


      context 'via token auth' do
        let(:user) { build(:user) }
        let(:source) { "Concrn iOS 1.2" }
        header 'Authorization', :authorization
        let(:authorization) { "Bearer #{user.token}" }

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
end
