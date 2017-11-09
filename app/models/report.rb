class Report < ApplicationRecord
  after_commit :queue_initial_prompt, on: :create
  has_many :messages
  belongs_to :reporter

  def queue_initial_prompt
    ReportPromptInitialJob.set(wait: (0.5).seconds).perform_later(self)
  end

  def handle(message)
    return unless message.from == reporter
    return unless next_handler.present?
    handler_class = "ReportReply#{next_handler.classify}Job".constantize
    handler_class.perform_later(message)
  end
end
