require "rails_helper"

describe Report do
  let(:report) do
    Report.new(
      lat: 29.9705879,
      long: -90.0519629,
      address: "1233 St. Roch Ave, New Orleans, LA, 70117",
      reporter_notes: "Something is wrong",
      source: "sms",
      google_place_id: "ChIJuaBEBSGmIIYRKvHBiJBuYW8"
    )
  end

  let(:reporter) { create(:user) }

  describe "creating a report" do

    it "enqueus a zip resolve job if no zip exists" do
      expect {
        Report::Commands::Create.perform(report: report, user: reporter)
      }.to have_enqueued_job(Report::ResolveZipJob)
    end

    it "enqueues a dispatch job if a zip exists" do
      report.zip = "70117"
      expect {
        Report::Commands::Create.perform(report: report, user: reporter)
      }.to have_enqueued_job(Report::DispatchJob)
    end
  end

  describe "dispatching a report" do
    let!(:affiliate) do
      Affiliate.create(
        name: "Las Vegas Rangers",
      ).tap do |a|
        a.zip_fences.create(zip: "70117")
        a.zip_fences.create(zip: "70113")
      end
    end
    let!(:responder_user) { create(:user, affiliate: affiliate, role: "affiliate_responder") }

    before do
      report.zip = "70117"
      Report::Commands::Create.perform(report: report, user: reporter)
    end

    describe "dispatching responders by zip" do
      let!(:responder) do
        Responder.create(
          user: responder_user,
          available: true,
        ).tap do |r|
          r.zip_fences.create(zip: "70117")
        end
      end

      it "attempts dispatch on responders by zip" do
        expect {
          Report::DispatchJob.perform_now(report_id: report.id)
        }.to have_enqueued_job(Report::DispatchAttemptJob).with(report_id: report.id, responder_id: responder.id, distance: 1000)
      end
    end

    describe "dispatching responders by point" do
      # 1000 Royal St, New Orleans
      let(:lat) { 29.953363 }
      let(:long) { -90.068796 }

      let!(:responder) do
        Responder.create(
          user: responder_user,
          available: true,
        ).tap do |r|
          r.point_fences.create(lat: lat, long: long, radius: 2.5)
        end
      end

      it "attempts dispatch on responders by point" do
        expect {
          Report::DispatchJob.perform_now(report_id: report.id)
        }.to have_enqueued_job(Report::DispatchAttemptJob).with(report_id: report.id, responder_id: responder.id, distance: instance_of(Float))
      end
    end
  end
end
