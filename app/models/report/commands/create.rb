class Report::Commands::Create < Command
  required_params :user, :report

  def perform
    report.reporter = Reporter.find_or_create_by(user: user)
    report.status = "new"
    report.report_events << report_event
    if report.save
      report.resolve_zip! unless report.zip.present?
      report.tap(&:dispatch!)
    else
      report
    end
  end

  def report_event
    report.report_events.build(
      event_type: ReportEvent::REPORT_CREATED,
      payload: {
        reporter_user_name: report.reporter.user.name,
        reporter_user_phone: report.reporter.user.phone,
        report_reporter_notes: report.reporter_notes,
        report_source: report.source
      }
    )
  end
end
