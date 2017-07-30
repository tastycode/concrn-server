require 'ostruct'
class Message < ApplicationRecord
  after_create :broadcast
  belongs_to :report
  belongs_to :from, polymorphic: true, optional: true
  belongs_to :to, polymorphic: true, optional: true

  scope :inbound,-> { joins(:report).where("report.reporter_id = messages.from_id and messages.from_type = 'Reporter'") }

  def from
    super || OpenStruct.new(name: 'Concrn')
  end

  def broadcast
    if report
      ReportsChannel.broadcast_to(report,
                                   id: id,
                                   from: from.name,
                                   text: text)
    end
  end
end
