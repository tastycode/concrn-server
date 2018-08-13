class Report::Commands::AttemptDispatch < Command
  required_params :report, :responder
  optional_params :distance
  def perform
    dispatch = ::Dispatch.create(
      dispatch_type: "AUTO",
      report: report,
      responder: responder,
      status: Dispatch::STATUS_PENDING,
    )

    # send text to responder
    response = ConcrnServer2.twilio
      .studio
      .flows(ENV['TWILIO_FLOW_OUTGOING_ID'])
      .engagements
      .create(
        from: ConcrnServer2.twilio.phone,
        to: responder.user.phone,
        parameters: {
          report_id: report.id,
          dispatch_id: dispatch.id,
          report_reporter_user_name: report.reporter.user.name,
          report_reporter_user_phone: report.reporter.user.phone,
          report_address: report.address,
          report_reporter_notes: report.reporter_notes
        }.to_json
    )

    p response

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
