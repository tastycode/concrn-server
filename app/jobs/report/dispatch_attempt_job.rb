class Report::DispatchAttemptJob < ApplicationJob
  def perform(report_id:, responder_id:, distance:)
    report = Report.find(report_id)
    responder = Responder.find(responder_id)
    Report::Commands::DispatchAttempt
      .perform(report: report, responder: responder, distance: distance)
  end
end
