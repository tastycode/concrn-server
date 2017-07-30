class ReportPromptNotesJob < ApplicationJob
  def perform(report)
    Message.create(
      report: report,
      handler: 'notes',
      text: "Thanks. We're working on getting a hold of people in your communiy who can help. In the meantime, can you tell us anything else?"
    )
    ReportCheckFinishedNotesJob.set(wait: 7.seconds).perform_later
  end
end
