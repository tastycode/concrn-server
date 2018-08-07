require "rails_helper"

describe Dispatch do
  include ActiveJob::TestHelper
  let(:reporter) { Reporter.find_or_create_by(user: create(:user)) }
  let!(:affiliate) { Affiliate.create(name: "Las Vegas Rangers")}
  let!(:responder_user) { create(:user, affiliate: affiliate, role: "affiliate_responder") }
  let!(:responder) { Responder.create( user: responder_user) }
  let(:report_status) { "PENDING"}
  let(:report) do
    Report.create(
      lat: 29.9705879,
      long: -90.0519629,
      address: "1233 St. Roch Ave, New Orleans, LA, 70117",
      reporter: reporter,
      reporter_notes: "Something is wrong",
      status: report_status,
      source: "sms",
      google_place_id: "ChIJuaBEBSGmIIYRKvHBiJBuYW8"
    )
  end

  let(:dispatch) {
    Dispatch.create(
      status: "PENDING",
      responder: responder,
      report: report
    )
  }

  describe "for pending reports" do
    describe "responding with accept" do
      it "creates the event and updates the report" do
        Dispatch::Commands::Update.perform(
          dispatch: dispatch,
          updates: {
            status: "ACCEPTED"
          }
        )
        expect(report.reload.status).to eq("ASSIGNED")
        expect(report.responder_id).to eq(dispatch.responder_id)
        last_event = report.report_events.last
        expect(last_event.event_type).to eq(ReportEvent::RESPONDER_DISPATCHED)
      end
    end

    describe "responding to an already accepted report" do
      let!(:responder_user2) { create(:user, affiliate: affiliate, role: "affiliate_responder") }
      let!(:responder2) { Responder.create( user: responder_user) }
      let(:dispatch2) {
        Dispatch.create(
          status: "PENDING",
          responder: responder2,
          report: report
        )
      }

      it "does not allow duplicate dispatch" do
        Dispatch::Commands::Update.perform(
          dispatch: dispatch,
          updates: {
            status: "ACCEPTED"
          }
        )
        dispatch_result = Dispatch::Commands::Update.perform(
          dispatch: dispatch2,
          updates: {
            status: "ACCEPTED"
          }
        )
        expect(dispatch2.status).to eq "STALE"
      end
    end

    describe "responding with dismiss" do
      it "updates the report and creates the event" do
        Dispatch::Commands::Update.perform(
          dispatch: dispatch,
          updates: {
            status: "DISMISSED"
          }
        )
        expect(report.reload.status).to eq("DISMISSED")
        last_event = report.report_events.last
        expect(last_event.event_type).to eq(ReportEvent::REPORT_DISMISSED)
      end
    end
  end
end
