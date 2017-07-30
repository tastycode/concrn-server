class Report < ApplicationRecord
  after_commit :queue_initial_prompt, on: :create
  has_many :messages
  belongs_to :reporter

  def queue_initial_prompt
    ReportPromptInitialJob.set(wait: 3.seconds).perform_later(self)
  end
end
