class ReportEvent < ApplicationRecord
  belongs_to :report
  REPORT_CREATED = "REPORT_CREATED"
  RESPONDER_DISPATCH_ATTEMPTED = "RESPONDER_DISPATCH_ATTEMPTED"
  RESPONDER_DISPATCH_ANSWERED = "RESPONDER_DISPATCH_ANSWERED"
  RESPONDER_DISPATCHED = "RESPONDER_DISPATCHED"
  REPORT_DISMISSED = "REPORT_DISMISSED"
  RESPONDER_ARRIVED = "RESPONDER_ARRIVED"
  RESPONDER_CLOSED = "RESPONDER_CLOSED"
end
