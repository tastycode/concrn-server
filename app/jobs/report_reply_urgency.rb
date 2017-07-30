class ReportRepliedUrgencyJob< ApplicationJob
  def perform(report)
    ReportPromptNotesJob.perform_later(report)
  end
end
