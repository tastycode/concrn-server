class Report::Commands::AttemptDispatch < Command
  required_params :report, :responder
  optional_params :distance
  def perform
    dispatch = Dispatch.create(
      dispatch_type: "AUTO",
      report: report,
      responder: responder,
      status: "PENDING"
    )

    # send text to responder
    ConcrnServer2.twilio.messages.create(
      from: ConcrnServer2.twilio.phone,
      to: responder.user.phone,
      body: dispatch_message_body
    )

    report.report_events << report_event
    report.tap(&:save)
  end

  def dispatch_message_body
    %Q{#{report.reporter.user.name} (#{report.reporter.user.phone}) reported
    a crisis at #{report.address}.
    Here's their notes: "#{report.reporter_notes}"}
  end

  def report_event
    report.report_events.build(
      event_type: ReportEvent::RESPONDER_DISPATCH_ATTEMPTED,
      payload: {
        affiliate_name: responder.user.affiliate.name,
        affiliate_id: responder.user.affiliate.id,
        responder_user_name: responder.user.name,
        responder_user_id: responder.user.id,
        responder_user_phone: responder.user.phone,
        distance: distance
      }
    )
  end
end
