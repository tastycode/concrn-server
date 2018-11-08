class ReportNote < ApplicationRecord
  belongs_to :user
  belongs_to :report
  after_commit :create_report_event, on: :create
  after_commit :notify, on: :create, if: :notify_reporter


  def notify
    response = ConcrnServer2.twilio.messages.create(
      from: ConcrnServer2.twilio.reporter_phone,
      to: report.reporter.user.phone,
      body: "Thanks for using Concrn, here are some notes from your responder: #{notes}"
    )
  end

  def create_report_event
    report.report_events.create(
      event_type: ReportEvent::REPORT_NOTE_ADDED,
      payload: {
        notify_reporter: notify_reporter,
        affiliate_name: user.affiliate&.name,
        user_id: user.id,
        user_name: user.name,
        notes: notes
      }
    )
  end
end
