class ReportReplyUrgencyJob < ApplicationJob
  def perform(message)
    if urgency = message[/yes|no/i]
      message.report.update_attributes(urgency: urgency.downcase)
    end
    message.report.update_attributes(next_handler: nil)
    ReportPromptNotesJob.set(wait: 2.seconds).perform_later(message.report)
  end
end
