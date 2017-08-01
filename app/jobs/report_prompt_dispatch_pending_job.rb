class ReportPromptDispatchPendingJob < ApplicationJob
  def perform(report)
    Message.create(
      report: report,
      text: "Thanks. We're still seeing if someone can come help out. We'll let you know when someone is coming."
    )
  end
end
