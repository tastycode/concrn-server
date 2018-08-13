class Dispatch < ApplicationRecord
  belongs_to :report
  belongs_to :responder

  STATUS_PENDING = "PENDING"
  STATUS_ACCEPTED = "ACCEPTED"
  STATUS_STALE = "STALE"
  STATUS_NO_RESPONSE = "NO_RESPONSE"
  STATUS_DISMISSED = "DISMISSED"
end
