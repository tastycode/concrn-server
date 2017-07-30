class ReportPromptInitialJob < ApplicationJob
  def perform(report)
    Message.create(
      report: report,
      to: report.reporter,
      handler: 'urgency',
      text: "Thanks for letting your neighbors know you're concerned. Is anyone at risk of immediate harm? (Yes/No)"
    )
  end
end
