class ReportNote < ApplicationRecord
  belongs_to :user
  belongs_to :report
  after_commit :create_report_event, on: :create

  def create_report_event
    report.report_events.create(
      event_type: ReportEvent::REPORT_NOTE_ADDED,
      payload: {
        affiliate_name: user.affiliate&.name,
        user_id: user.id,
        user_name: user.name,
        notes: notes
      }
    )
  end
end
