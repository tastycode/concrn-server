class Report::DispatchJob < ApplicationJob
  include ActiveJob::Retry.new(strategy: :variable,
                               delays: [30.seconds, 1.minutes, 2.minutes],
                               retryable_exceptions: [Report::ZipMissingError])
  def perform(report_id:)
    report = Report.find(report_id)
    Report::Commands::Dispatch.perform(report: report)
  end
end
