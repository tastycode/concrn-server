require 'ostruct'
class Message < ApplicationRecord
  after_create :broadcast
  after_create :handle
  belongs_to :report
  belongs_to :from, polymorphic: true, optional: true
  belongs_to :to, polymorphic: true, optional: true

  scope :inbound,-> { joins(:report).where("reports.reporter_id = messages.from_id and messages.from_type = 'Reporter'") }

  def from
    super || User.concrn
  end

  def broadcast
    if report
      ReportsChannel.broadcast_to(report,
                                   id: id,
                                   message: MessageSerializer.new(self).as_json)
    end
  end

  def handle
    report.handle(self)
  end
end
