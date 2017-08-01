class ReportCheckFinishedNotesJob < ApplicationJob
  WAIT = 20.seconds
  def perform(report)
    last_message = report.messages.inbound.order("created_at desc").first
    if last_message && last_message.created_at < WAIT.ago
      ReportPromptDispatchPendingJob.perform_later(report)
    else
      ReportCheckFinishedNotesJob.set(wait: WAIT).perform_later(report)
    end
  end
end
